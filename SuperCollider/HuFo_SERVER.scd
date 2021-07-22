/*

Mixing and HOA rendering software for the HuFo.

- parallel use of internal HOA and external WFS
- additional send bus for subwoofer output

- allows individual delays for all outputs

Henrik von Coler
2021-01-05

*/

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Configurations
///////////////////////////////////////////////////////////////////////////////////////////////////////////

~server_ADDRESS = 58010;

// number spatial input modules
~nInputs   = 64;

// delays (sec.) for output units (guessed, at this point)
~wfs_DELAY = 0;
~hoa_DELAY = 0.02;
~sub_DELAY = 0.03;

~hoa_GAIN = 1;

~crossover_freq = 100;

~debug_level    = 0;

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Two kinds of send buses, held in individual arrays:
///////////////////////////////////////////////////////////////////////////////////////////////////////////

// number of individual sends per input
// 0: hoa
// 1: wfs
~nIndividualSends = 2;
// number of common sends:
// 0: LFE
~nCommonSends     = 1;


///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Command line arguments
///////////////////////////////////////////////////////////////////////////////////////////////////////////

postln(thisProcess.argv[0]);

if(size(thisProcess.argv)==1,
	{
		~nInputs   = thisProcess.argv[0].asInteger;
});
postln("Launching with "++~nInputs++" inputs!");

if(size(thisProcess.argv)==2,
	{
		~server_ADDRESS   = thisProcess.argv[1].asInteger;
});
postln("Launching with port:"++~server_ADDRESS++"!");

// get script's directory for relative paths
~root_DIR = thisProcess.nowExecutingPath.dirname++"/";


///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Server Stuff
///////////////////////////////////////////////////////////////////////////////////////////////////////////

// Server.supernova;

// Server.default = Server(\binaural_server, NetAddr("127.0.0.1", ~server_ADDRESS));

s.options.device               = "SC_MIX";
s.options.numInputBusChannels  = ~nInputs;
s.options.numOutputBusChannels = 128;

s.options.maxLogins            = 2;
s.options.memSize              = 65536;
s.options.numBuffers           = 4096;

s.options.numAudioBusChannels = 4096;

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// HOA parameters
///////////////////////////////////////////////////////////////////////////////////////////////////////////

~hoa_order      = 3;
~n_hoa_speakers = 45;

~n_hoa_channnels = pow(~hoa_order + 1.0 ,2.0);


// the reverb is 1st order
~reverb_order      = 1;
~n_reverb_channels = pow(~reverb_order + 1.0 ,2.0);

s.boot;

~routing_OSC  = NetAddr("127.0.0.1", 9595);
~spatial_OSC  = NetAddr("127.0.0.1", 9494);



///////////////////////////////////////////////////////////////////////////////////////////////////////////
// BOOT and Start
///////////////////////////////////////////////////////////////////////////////////////////////////////////

s.waitForBoot({

	// load necessary HOA stuff
	HOABinaural.loadbinauralIRs(s);
	HOABinaural.loadHeadphoneCorrections(s);
	HOABinaural.binauralIRs;
	HOABinaural.headPhoneIRs;

	s.sync;

	// load all synthdefs
	load(~root_DIR++"HuFo_MISC_SYNTHDEFS.sc","r");
	load(~root_DIR++"HuFo_HOA_SYNTHDEFS.sc","r");


	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	// CONTROL BUSSES:
	///////////////////////////////////////////////////////////////////////////////////////////////////////////

	s.sync;

	~control_azim_BUS     = Bus.control(s,~nInputs);
	~control_elev_BUS     = Bus.control(s,~nInputs);
	~control_dist_BUS     = Bus.control(s,~nInputs);

	~reverb_gain_BUS  = Bus.control(s,~nInputs);
	~sub_gain_BUS     = Bus.control(s,~nInputs);

	// control
	~send_gain_BUSES = Array.fill(~nInputs,
		{Bus.control(s, ~nIndividualSends)}
	);

	s.sync;

	~common_gain_BUSES = Array.fill(~nInputs,
		{Bus.control(s, ~nCommonSends);}
	);

	s.sync;

	~send_BUSES = Array.fill(~nInputs,
		{Bus.audio(s, ~nIndividualSends);}
	);

	s.sync;

	~reverb_gain_BUS.set(0);
	~sub_gain_BUS.set(0);


	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	// AUDIO BUSSES:
	///////////////////////////////////////////////////////////////////////////////////////////////////////////

	~common_send_BUSES = Bus.audio(s, ~nCommonSends);
	~sub_BUS           = Bus.audio(s, 1);

	// bus for encoded HOA
	~ambi_BUS   = Bus.audio(s, ~n_hoa_channnels);

	// bus for reverb (starting with mono for a trial)
	~reverb_BUS = Bus.audio(s,1);

	s.sync;

	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	// ROUTING SECTION
	///////////////////////////////////////////////////////////////////////////////////////////////////////////

	~send_GROUP = Group.new;

	for (0, ~nInputs -1, {arg cnt;

		post('Adding send Module: ');
		cnt.postln;

		~send_modules = ~send_modules.add(
			Synth(\send_module,
				[
					\in_chan,          cnt,
					\send_bus,         ~send_BUSES[cnt].index,
					\individual_gains, ~send_gain_BUSES[cnt].index,
					\common_gains,     ~common_gain_BUSES[cnt].index,
					\common_bus,       ~common_send_BUSES.index,
					\reverb_bus,       ~reverb_BUS.index,
					\sub_bus,          ~sub_BUS.index,
				],target: ~send_GROUP
		);)
	});


	for (0, ~nInputs -1, {arg cnt;
		~send_modules[cnt].map(\dist,             ~control_dist_BUS.index  + cnt);
		~send_modules[cnt].map(\reverb_gain,      ~reverb_gain_BUS.index  + cnt);
		~send_modules[cnt].map(\sub_gain,      ~sub_gain_BUS.index  + cnt);
	};);


	~sends_OSC = OSCFunc({ arg msg, time, addr, recvPort;

		var in_value;
		in_value = msg[3];

		if(~debug_level == 1,{msg.postln()});

		in_value = max(0,min(1,in_value));

		~send_gain_BUSES[msg[1]].setAt(msg[2], in_value);

	}, '/source/send/spatial');


	~common_sends_OSC = OSCFunc({ arg msg, time, addr, recvPort;

		var in_value;
		in_value = msg[3];

		if(~debug_level == 1,{msg.postln()});

		in_value = max(0,min(1,in_value));

		~common_gain_BUSES[msg[1]].setAt(msg[2], in_value);

	}, '/source/send/direct');



	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	// SPATIAL SECTION
	///////////////////////////////////////////////////////////////////////////////////////////////////////////

	~spatial_GROUP = Group.after(~send_GROUP);

	for (0, ~nInputs -1, {arg cnt;

		post('Adding HOA panning Module: ');
		cnt.postln;

		~hoa_panners = ~hoa_panners.add(
			Synth(\binaural_mono_encoder_3,
				[
					\in_bus,  ~send_BUSES[cnt].index,
					\out_bus,  ~ambi_BUS.index
				],
				target: ~spatial_GROUP
		);)
	});




	for (0, ~nInputs -1, {arg cnt;

		post('Mapping HOA module: ');
		cnt.postln;

		~hoa_panners[cnt].map(\azim, ~control_azim_BUS.index  + cnt);
		~hoa_panners[cnt].map(\elev, ~control_elev_BUS.index  + cnt);
		~hoa_panners[cnt].map(\dist, ~control_dist_BUS.index  + cnt);

	});

	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	// OSC listeners:
	///////////////////////////////////////////////////////////////////////////////////////////////////////////


	~azim_OSC = OSCFunc(
		{
			arg msg, time, addr, recvPort;
			var azim = msg[2];

			if(~debug_level == 1,{msg.postln()});

			~control_azim_BUS.setAt(msg[1],azim);
	}, '/source/pos/azim');

	~elev_OSC = OSCFunc(
		{
			arg msg, time, addr, recvPort;
			var elev = msg[2];

			if(~debug_level == 1,{msg.postln()});

			~control_elev_BUS.setAt(msg[1],elev);
	}, '/source/pos/elev');

	~dist_OSC = OSCFunc(
		{
			arg msg, time, addr, recvPort;
			var dist = msg[2];

			if(~debug_level == 1,{msg.postln()});

			dist = max(0,min(100,dist));

			~control_dist_BUS.setAt(msg[1],dist);
	}, '/source/pos/dist');


	~aed_OSC = OSCFunc(
		{
			arg msg, time, addr, recvPort;

			var azim = msg[2];// / 360.0 * (2.0*pi);
			var elev = msg[3];// / 360.0 * (2.0*pi);
			var dist = msg[4];

			if(~debug_level == 1,{msg.postln()});

			dist = max(0,min(100,dist));

			~control_azim_BUS.setAt(msg[1],azim);
			~control_elev_BUS.setAt(msg[1],elev);
			~control_dist_BUS.setAt(msg[1],dist);

	}, '/source/pos/aed');


	~reverb_OSC = OSCFunc(
		{
			arg msg, time, addr, recvPort;
			var gain = msg[2];

			if(~debug_level == 1,{msg.postln()});

			gain = max(0,min(1,gain));

			~reverb_gain_BUS.setAt(msg[1],gain);
	}, '/source/reverb/gain');


	~sub_OSC = OSCFunc(
		{
			arg msg, time, addr, recvPort;
			var dist = msg[2];

			if(~debug_level == 1,{msg.postln()});

			~sub_gain_BUS.setAt(msg[1],dist);
	}, '/source/sub/gain');




	~send_OSC_ROUTINE = Routine({

		inf.do({

			var azim, elev, dist;


			for (0, ~nInputs-1, { arg i;

				azim = ~control_azim_BUS.getnSynchronous(~nInputs)[i];
				elev = ~control_elev_BUS.getnSynchronous(~nInputs)[i];
				dist = ~control_dist_BUS.getnSynchronous(~nInputs)[i];

				~spatial_OSC.sendMsg('/source/pos/aed', i, azim, elev, dist);

			});

			0.01.wait;
		});

	});

	~send_OSC_ROUTINE.play;




	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	// decoder
	///////////////////////////////////////////////////////////////////////////////////////////////////////////

	~output_GROUP	 = Group.after(~spatial_GROUP);

	// use external decoder instead
	/*
	~decoder = Synth(\hoa_decoder_HUFO,
	[
	\in_bus,~ambi_BUS.index,
	\out_bus, 0
	],
	target: ~output_GROUP);
	*/

	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	// add one output module for each HOA channel
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	for (0, ~n_hoa_channnels -1, {arg cnt;

		post('Adding HOA output Module: ');
		cnt.postln;

		~hoa_outputs = ~hoa_outputs.add(
			Synth(\output_module,
				[
					\audio_bus, ~ambi_BUS.index+cnt,  // individual HOA channels (IDX=0)
					\out_bus, ~nInputs + cnt                 // 64 + 16
				],
				target: ~output_GROUP
		);)
	});

	~hoa_outputs.do({ arg item, i; item.set(\delay, ~hoa_DELAY); });
	~hoa_outputs.do({ arg item, i; item.set(\hp_cutoff,~crossover_freq); });
	~hoa_outputs.do({ arg item, i; item.set(\gain,5); });

	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	// add one output module for each WFS channel
	///////////////////////////////////////////////////////////////////////////////////////////////////////////

	for (0, ~nInputs -1, {arg cnt;

		post('Adding WFS output Module: ');
		cnt.postln;

		~wfs_outputs = ~wfs_outputs.add(
			Synth(\output_module,
				[
					\audio_bus, ~send_BUSES[cnt].index+1,  // individual HOA channels (IDX = 1)
					\out_bus, cnt      // first outputs are WFS
				],
				target: ~output_GROUP
		);)
	});

	~wfs_outputs.do({ arg item, i; item.set(\delay, ~wfs_DELAY); });
	~wfs_outputs.do({ arg item, i; item.set(\hp_cutoff,~crossover_freq); });


	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	// Reverb Output
	///////////////////////////////////////////////////////////////////////////////////////////////////////////

	// global reverb parameters
	~reverb_gain_global_BUS  = Bus.control(s,1).set(1);
	~reverb_f1_global_BUS    = Bus.control(s,1).set(500);
	~reverb_f2_global_BUS    = Bus.control(s,1).set(2700);
	~reverb_rdel_global_BUS  = Bus.control(s,1).set(10);
	~reverb_rgxyz_global_BUS = Bus.control(s,1).set(0);
	~reverb_t60dc_global_BUS = Bus.control(s,1).set(1.75);
	~reverb_t60m_global_BUS  = Bus.control(s,1).set(3.5);

	~reverb_lp_freq_global_BUS = Bus.control(s,1).set(2000);
	~reverb_lp_rs_global_BUS   = Bus.control(s,1).set(0.5);
	~reverb_lp_db_global_BUS   = Bus.control(s,1).set(-10);

	~reverb = {

		|gain = 1, f1= 300.0, f2= 2000.0, rdel= 2.0, rgxyz= 0, t60dc= 3.0, t60m= 4.0, freq= 2000, rs= 0.5, db= -10 |

		var sig = BHiShelf.ar(In.ar(~reverb_BUS.index),freq,rs,db);

		Out.ar(~nInputs + ~n_hoa_channnels, gain*FoaReverb.ar(2*sig,f1,f2,rdel,rgxyz,t60dc,t60m));

	}.play;
	s.sync;

	~reverb.moveToTail(~output_GROUP);



	~reverb.map(\gain, ~reverb_gain_global_BUS);
	~reverb.map(\f1, ~reverb_f1_global_BUS);
	~reverb.map(\f2, ~reverb_f2_global_BUS);

	~reverb.map(\rdel, ~reverb_rdel_global_BUS);
	~reverb.map(\rgxyz, ~reverb_rgxyz_global_BUS);
	~reverb.map(\t60dc, ~reverb_t60dc_global_BUS);
	~reverb.map(\t60m, ~reverb_t60m_global_BUS);

	~reverb.map(\freq, ~reverb_lp_freq_global_BUS);
	~reverb.map(\rs, ~reverb_lp_rs_global_BUS);
	~reverb.map(\db, ~reverb_lp_db_global_BUS);



	OSCdef(\reverb_gain,
		{
		arg msg, time, addr, recvPort;

			var value = msg[1];
			value     = max(0,min(1,value));

			if(~debug_level == 1,{msg.postln()});

			~reverb_gain_global_BUS.set(value);

	},'/reverb/gain');


	OSCdef(\reverb_f1,
		{
		arg msg, time, addr, recvPort;

			var value = msg[1];
			value     = max(10,min(10000,value));

			if(~debug_level == 1,{msg.postln()});

			~reverb_f1_global_BUS.set(value);

	},'/reverb/f1');


	OSCdef(\reverb_f2,
		{
		arg msg, time, addr, recvPort;

			var value = msg[1];
			value     = max(10,min(10000,value));

			if(~debug_level == 1,{msg.postln()});

			~reverb_f2_global_BUS.set(value);

	},'/reverb/f2');


	OSCdef(\reverb_rdel,
		{
		arg msg, time, addr, recvPort;

			var value = msg[1];
			value     = max(0,min(100,value));

			if(~debug_level == 1,{msg.postln()});

			~reverb_rdel_global_BUS.set(value);

	},'/reverb/rdel');


	OSCdef(\reverb_rgxyz,
		{
		arg msg, time, addr, recvPort;

			var value = msg[1];
			value     = max(-9,min(9,value));

			if(~debug_level == 1,{msg.postln()});

			~reverb_rgxyz_global_BUS.set(value);

	},'/reverb/rgxyz');


	OSCdef(\reverb_t60dc,
		{
		arg msg, time, addr, recvPort;

			var value = msg[1];
			value     = max(0.01,min(10,value));

			if(~debug_level == 1,{msg.postln()});

			~reverb_t60dc_global_BUS.set(value);

	},'/reverb/t60dc');


	OSCdef(\reverb_t60m,
		{
		arg msg, time, addr, recvPort;

			var value = msg[1];
			value     = max(0.01,min(10,value));

			if(~debug_level == 1,{msg.postln()});

			~reverb_t60m_global_BUS.set(value);

	},'/reverb/t60m');


	OSCdef(\reverb_lp_freq,
		{
		arg msg, time, addr, recvPort;

			var value = msg[1];
			value     = max(10,min(20000,value));

			if(~debug_level == 1,{msg.postln()});
			~reverb_lp_freq_global_BUS.set(value);

	},'/reverb/lp/freq');




	OSCdef(\reverb_lp_rs,
		{
		arg msg, time, addr, recvPort;

			var value = msg[1];
			value     = max(0,min(1,value));

			if(~debug_level == 1,{msg.postln()});
			~reverb_lp_rs_global_BUS.set(value);

	},'/reverb/lp/rs');


	OSCdef(\reverb_lp_db,
		{
		arg msg, time, addr, recvPort;

			var value = msg[1];
			value     = max(-24,min(6,value));

			if(~debug_level == 1,{msg.postln()});
			~reverb_lp_db_global_BUS.set(value);

	},'/reverb/lp/db');



	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	// add BASS
	///////////////////////////////////////////////////////////////////////////////////////////////////////////

	~lfe_output = Synth(\sub_output_module,
		[
			\audio_bus, ~common_send_BUSES.index + 0,  //
			\out_bus,   ~nInputs + ~n_hoa_channnels + ~n_reverb_channels   // output after reverb
		],
		target: ~output_GROUP
	);

	~lfe_output.set(\delay, ~sub_DELAY);
	~lfe_output.set(\lp_cutoff,~crossover_freq);

	~sub_output = Synth(\sub_output_module,
		[
			\audio_bus, ~sub_BUS.index,  //
			\out_bus,   ~nInputs  + ~n_hoa_channnels + ~n_reverb_channels  // output after reverb
		],
		target: ~output_GROUP
	);


	~sub_output.set(\delay, ~sub_DELAY);
	~sub_output.set(\lp_cutoff,~crossover_freq);

	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	//
	///////////////////////////////////////////////////////////////////////////////////////////////////////////

	post("Listening on port: ");
	postln(NetAddr.langPort);


});





