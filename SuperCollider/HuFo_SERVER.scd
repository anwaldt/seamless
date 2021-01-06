/*

Mixing and HOA rendering software for the HuFo.

- parallel use of internal HOA and external WFS
- additional send bus for subwoofer output

- allows individual delays for all outputs

Henrik von Coler
2021-01-05

*/

~server_ADDRESS = 58010;

// number spatial input modules
~nInputs   = 64;

/////////////////////////////////////////////////////////////////
// Two kinds of send buses, held in individual arrays:
/////////////////////////////////////////////////////////////////

// number of individual sends per input
// 0: hoa
// 1: wfs
~nSends       = 3;
// number of common sends:
// 0: sub
~nCommonSends = 1;


/////////////////////////////////////////////////////////////////
// BASIC
/////////////////////////////////////////////////////////////////

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


/////////////////////////////////////////////////////////////////
// Server Stuff
/////////////////////////////////////////////////////////////////

// Server.supernova;

Server.default = Server(\binaural_server, NetAddr("127.0.0.1", ~server_ADDRESS));

s.options.device               = "SC_HOA";
s.options.numInputBusChannels  = ~nInputs;
s.options.numOutputBusChannels = 128;

s.options.maxLogins            = 2;
s.options.memSize              = 65536;
s.options.numBuffers           = 4096;




/////////////////////////////////////////////////////////////////
// HOA parameters
/////////////////////////////////////////////////////////////////

~hoa_order      = 3;
~n_hoa_speakers = 21;

~n_hoa_channnels = pow(~hoa_order + 1.0 ,2.0);

SynthDef(\hoa_decoder_EN325, {

	|in_bus = 0|


	Out.ar(0,EN325DOME3.ar(
		In.ar(in_bus ),
		In.ar(in_bus +1),
		In.ar(in_bus +2),
		In.ar(in_bus +3),
		In.ar(in_bus +4),
		In.ar(in_bus +5),
		In.ar(in_bus +6),
		In.ar(in_bus +7),
		In.ar(in_bus +8),
		In.ar(in_bus +9),
		In.ar(in_bus +10),
		In.ar(in_bus +11),
		In.ar(in_bus +12),
		In.ar(in_bus +13),
		In.ar(in_bus +14),
		In.ar(in_bus +15),
		gain:1) );

}).add;


s.boot;

~routing_OSC  = NetAddr("127.0.0.1", 9595);
~spatial_OSC  = NetAddr("127.0.0.1", 9494);

s.waitForBoot({

	// load necessary HOA stuff
	HOABinaural.loadbinauralIRs(s);
	HOABinaural.loadHeadphoneCorrections(s);
	HOABinaural.binauralIRs;
	HOABinaural.headPhoneIRs;

	s.sync;

	// load all synthdefs
	load(~root_DIR++"sc_spat_SYNTHDEFS.sc","r");

	/////////////////////////////////////////////////////////////////
	// THE BUSSES:
	/////////////////////////////////////////////////////////////////

	s.sync;

	~control_azim_BUS     = Bus.control(s,~nInputs);
	~control_elev_BUS     = Bus.control(s,~nInputs);
	~control_dist_BUS     = Bus.control(s,~nInputs);

	// control
	~send_gain_BUSES = Array.fill(~nInputs,
		Bus.control(s, ~nSends)
	);

	~common_gain_BUSES = Array.fill(~nInputs,
			Bus.control(s, ~nCommonSends);
	);


	// create audio bus for each spatialization module:
	// ~audio_BUS_spatial      = Bus.audio(s, ~nInputs);

	~send_BUSES = Array.fill(~nInputs,
			Bus.audio(s, ~nSends);
	);

	// bus for encoded HOA
	~ambi_BUS = Bus.audio(s, ~n_hoa_channnels);

	~common_send_BUSES  = Bus.audio(s, ~nCommonSends);

	s.sync;


	/////////////////////////////////////////////////////////////////
	// ROUTING SECTION
/////////////////////////////////////////////////////////////////

	~send_GROUP = Group.new;

	for (0, ~nInputs -1, {arg cnt;

		post('Adding send Module: ');
		cnt.postln;

		~send_modules = ~send_modules.add(
			Synth(\send_module,
				[
					\in_chan,      cnt,
					\send_bus,     ~send_BUSES[cnt],
					\common_bus,   ~common_send_BUSES,
					\send_gains,   ~send_gain_BUSES[cnt],
					\common_gains, ~common_gain_BUSES[cnt],
				],target: ~send_GROUP
		);)
	});


	~sends_OSC = OSCFunc({ arg msg, time, addr, recvPort;

		var in_value;

		in_value = msg[3];

		~send_gain_BUSES[msg[1]].setAt(msg[2], in_value);

	}, '/send/gain/individual');


	~common_sends_OSC = OSCFunc({ arg msg, time, addr, recvPort;

		var in_value;

		in_value = msg[3];

		~common_gain_BUSES[msg[1]].setAt(msg[2], in_value);

	}, '/send/gain/common');



	/////////////////////////////////////////////////////////////////
	// SPATIAL SECTION
	/////////////////////////////////////////////////////////////////

	~spatial_GROUP = Group.after(~send_GROUP);

	for (0, ~nInputs -1, {arg cnt;

		post('Adding HOA panning Module: ');
		cnt.postln;

		~hoa_panners = ~hoa_panners.add(
			Synth(\binaural_mono_encoder_3,
				[
					\in_bus, ~send_BUSES[cnt].index,
					\out_bus, ~ambi_BUS.index
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




	/////////////////////////////////////////////////////////////////
	// decoder
	/////////////////////////////////////////////////////////////////

	~output_GROUP	 = Group.after(~spatial_GROUP);


	~decoder = Synth(\hoa_decoder_EN325,
		[
			\in_bus,~ambi_BUS.index,
			\out_bus, 0
		],
		target: ~output_GROUP);

	/////////////////////////////////////////////////////////////////
	// add one output module for each HOA channel
	/////////////////////////////////////////////////////////////////
	for (0, ~n_hoa_channnels -1, {arg cnt;

		post('Adding HOA output Module: ');
		cnt.postln;

		~hoa_outputs = ~hoa_outputs.add(
			Synth(\output_module,
				[
					\audio_bus, ~ambi_BUS.index+cnt,  // individual HOA channels
					\out_bus,   cnt                   // first outputs are HOA
				],
				target: ~output_GROUP
		);)
	});


	/////////////////////////////////////////////////////////////////
	// add one output module for each WFS channel
	/////////////////////////////////////////////////////////////////
	for (0, ~nInputs -1, {arg cnt;

		post('Adding WFS output Module: ');
		cnt.postln;

		~wfs_outputs = ~wfs_outputs.add(
			Synth(\output_module,
				[
					\audio_bus, ~send_BUSES[cnt].index+1,  // individual HOA channels
					\out_bus,   ~n_hoa_speakers + cnt      // first outputs are HOA
				],
				target: ~output_GROUP
		);)
	});


	/////////////////////////////////////////////////////////////////
	// add one SUB module
	/////////////////////////////////////////////////////////////////
	~sub_output = Synth(\sub_output_module,
		[
			\audio_bus, ~common_send_BUSES.index + 0,  //
			\out_bus,   ~n_hoa_speakers + ~nInputs     // output after WFS and HOA outputs
		],
		target: ~output_GROUP
	);

	/////////////////////////////////////////////////////////////////
	// OSC listeners:
	/////////////////////////////////////////////////////////////////


	~azim_OSC = OSCFunc(
		{
			arg msg, time, addr, recvPort;
			var azim = msg[2];
			~control_azim_BUS.setAt(msg[1],azim);
	}, '/source/azim');

	~elev_OSC = OSCFunc(
		{
			arg msg, time, addr, recvPort;
			var elev = msg[2];
			~control_elev_BUS.setAt(msg[1],elev);
	}, '/source/elev');

	~dist_OSC = OSCFunc(
		{
			arg msg, time, addr, recvPort;
			var dist = msg[2];
			~control_dist_BUS.setAt(msg[1],dist);
	}, '/source/dist');


	~aed_OSC = OSCFunc(
		{
			arg msg, time, addr, recvPort;

			var azim = msg[2] / 360.0 * (2.0*pi);
			var elev = msg[3] / 360.0 * (2.0*pi);
			var dist = msg[4];

			~control_azim_BUS.setAt(msg[1],azim);
			~control_elev_BUS.setAt(msg[1],elev);
			~control_dist_BUS.setAt(msg[1],dist);

	}, '/source/aed');


	~send_OSC_ROUTINE = Routine({

		inf.do({

			var azim, elev, dist;


			for (0, ~nInputs-1, { arg i;

				azim = ~control_azim_BUS.getnSynchronous(~nInputs)[i];
				elev = ~control_elev_BUS.getnSynchronous(~nInputs)[i];
				dist = ~control_dist_BUS.getnSynchronous(~nInputs)[i];

				~spatial_OSC.sendMsg('/source/aed', i, azim, elev, dist);

			});

			0.01.wait;
		});

	});

	~send_OSC_ROUTINE.play;

	/////////////////////////////////////////////////////////////////
	//
	/////////////////////////////////////////////////////////////////

	post("Listening on port: ");
	postln(NetAddr.langPort);
	ServerMeter(s);

});




{

	s.scope(12,~control_azim_BUS.index);

};


{

	// mouse xy controll with busses
	~mouse_BUS = Bus.control(s,2);


	~mouse   = {
		Out.kr(~control_azim_BUS.index,   MouseX.kr(-pi, pi));
		Out.kr(~control_elev_BUS.index, MouseY.kr(-1,1));
	}.play;

};







