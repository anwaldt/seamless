/*

A WFS only version of the SC mixer.

Henrik von Coler
2021-02-11

*/

/////////////////////////////////////////////////////////////////
// Configure
/////////////////////////////////////////////////////////////////

~debug_level    = 0;

~server_ADDRESS = 58010;

// number spatial input modules
~nInputs   = 64;

// delays (sec.) for output units (guessed, at this point)
~wfs_DELAY = 0;
~hoa_DELAY = 0.02;
~sub_DELAY = 0.03;

~crossover_freq = 100;

/////////////////////////////////////////////////////////////////
// Two kinds of send buses, held in individual arrays:
/////////////////////////////////////////////////////////////////

// number of individual sends per input
// 0: hoa
// 1: wfs
~nIndividualSends       = 2;
// number of common sends:
// 0: sub
~nCommonSends = 1;


/////////////////////////////////////////////////////////////////
// Command line arguments
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

// Server.default = Server(\binaural_server, NetAddr("127.0.0.1", ~server_ADDRESS));

s.options.device               = "SC_WFS";
s.options.numInputBusChannels  = ~nInputs;
s.options.numOutputBusChannels = 128;

s.options.maxLogins            = 2;
s.options.memSize              = 65536;
s.options.numBuffers           = 4096;

s.options.numAudioBusChannels = 4096;



s.boot;

~routing_OSC  = NetAddr("127.0.0.1", 9595);
~spatial_OSC  = NetAddr("127.0.0.1", 9494);

s.waitForBoot({


	// load all non-HOA synthdefs
	load(~root_DIR++"HuFo_MISC_SYNTHDEFS.sc","r");

	/////////////////////////////////////////////////////////////////
	// THE BUSSES:
	/////////////////////////////////////////////////////////////////

	s.sync;

	~control_azim_BUS     = Bus.control(s,~nInputs);
	~control_elev_BUS     = Bus.control(s,~nInputs);
	~control_dist_BUS     = Bus.control(s,~nInputs);

	// control
	~send_gain_BUSES = Array.fill(~nInputs,
		{
			Bus.control(s, ~nIndividualSends)
		}
	);

	s.sync;


	~common_gain_BUSES = Array.fill(~nInputs,
		{
			Bus.control(s, ~nCommonSends);
		}
	);

	s.sync;

	~send_BUSES = Array.fill(~nInputs,
		{
			Bus.audio(s, ~nIndividualSends);
		}
	);

	s.sync;

	~common_send_BUSES = Bus.audio(s, ~nCommonSends);
	~sub_BUS           = Bus.audio(s, 1);

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
					\in_chan,          cnt,
					\send_bus,         ~send_BUSES[cnt].index,
					\individual_gains, ~send_gain_BUSES[cnt].index,
					\common_gains,     ~common_gain_BUSES[cnt].index,
					\common_bus,       ~common_send_BUSES.index,
					\sub_bus,          ~sub_BUS.index,
				],target: ~send_GROUP
		);)
	});


	for (0, ~nInputs -1, {arg cnt;
		~send_modules[cnt].map(\dist,             ~control_dist_BUS.index  + cnt);
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



	/////////////////////////////////////////////////////////////////
	// SPATIAL SECTION
	/////////////////////////////////////////////////////////////////

	~spatial_GROUP = Group.after(~send_GROUP);


	/////////////////////////////////////////////////////////////////
	// OSC listeners:
	/////////////////////////////////////////////////////////////////

	//
	// ~azim_OSC = OSCFunc(
	// 	{
	// 		arg msg, time, addr, recvPort;
	// 		var azim = msg[2];
	// 		~control_azim_BUS.setAt(msg[1],azim);
	// }, '/source/pos/azim');
	//
	// ~elev_OSC = OSCFunc(
	// 	{
	// 		arg msg, time, addr, recvPort;
	// 		var elev = msg[2];
	// 		~control_elev_BUS.setAt(msg[1],elev);
	// }, '/source/pos/elev');
	//
	// ~dist_OSC = OSCFunc(
	// 	{
	// 		arg msg, time, addr, recvPort;
	// 		var dist = msg[2];
	// 		~control_dist_BUS.setAt(msg[1],dist);
	// }, '/source/pos/dist');
	//
	//
	// ~aed_OSC = OSCFunc(
	// 	{
	// 		arg msg, time, addr, recvPort;
	//
	// 		var azim = msg[2] / 360.0 * (2.0*pi);
	// 		var elev = msg[3] / 360.0 * (2.0*pi);
	// 		var dist = msg[4];
	//
	// 		~control_azim_BUS.setAt(msg[1],azim);
	// 		~control_elev_BUS.setAt(msg[1],elev);
	// 		~control_dist_BUS.setAt(msg[1],dist);
	//
	// }, '/source/pos/aed');
	//


	/////////////////////////////////////////////////////////////////
	// decoder
	/////////////////////////////////////////////////////////////////

	~output_GROUP	 = Group.after(~spatial_GROUP);



	/////////////////////////////////////////////////////////////////
	// add one output module for each WFS channel
	/////////////////////////////////////////////////////////////////

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


	/////////////////////////////////////////////////////////////////
	// add BASS
	/////////////////////////////////////////////////////////////////

	~lfe_output = Synth(\sub_output_module,
		[
			\audio_bus, ~common_send_BUSES.index + 0,  //
			\out_bus,   ~nInputs     // output after WFS
		],
		target: ~output_GROUP
	);

	~lfe_output.set(\delay, ~sub_DELAY);
	~lfe_output.set(\lp_cutoff,~crossover_freq);

	~sub_output = Synth(\sub_output_module,
		[
			\audio_bus, ~sub_BUS.index,  //
			\out_bus,   ~nInputs     // output after WFS
		],
		target: ~output_GROUP
	);


	~sub_output.set(\delay, ~sub_DELAY);
	~sub_output.set(\lp_cutoff,~crossover_freq);

	/////////////////////////////////////////////////////////////////
	//
	/////////////////////////////////////////////////////////////////

	post("Listening on port: ");
	postln(NetAddr.langPort);


});



/////////////////////////////////////////////////////////////////
// Debug Monitor
/////////////////////////////////////////////////////////////////
{

	/*

	ServerMeter(s);

	s.scope(12,~control_azim_BUS.index);

	s.scope(1,~send_gain_BUSES[0].index);
	s.scope(1,~send_BUSES[1].index);

	s.scope(1,~common_send_BUSES.index);

	s.scope(16,~common_send_BUSES.index);

	*/
};



