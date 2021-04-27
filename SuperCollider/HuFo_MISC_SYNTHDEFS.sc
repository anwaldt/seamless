
////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////


SynthDef(\mono_input,
	{
		|
		input_bus           = nil,
		gain                = nil,
		output_bus          = nil
		|

		var in;

		in = SoundIn.ar(input_bus);

		Out.ar(output_bus, in*gain);

}).add;

SynthDef(\input_module,
	{
		|
		input_bus           = nil,
		control_BUS_spatial = nil,
		output_bus          = nil
		|

		var in1, in2, output, gain;

		for (0, 15,
			{ arg cnt;

				// get the gain value from control bus:
				gain = In.kr(control_BUS_spatial + cnt);

				// get the audio input from hardware input:
				in1 = SoundIn.ar(input_bus);
				in2 = SoundIn.ar(input_bus+1);

				// audio output to dedicated bus
				Out.ar(output_bus + (cnt*2), [in1*gain, in2*gain]);

			}
		);

}).add;



SynthDef(\send_module,
	{

		|
		in_chan       = nil,
		send_bus      = nil,
		common_bus    = nil
		individual_gains    = nil,
		common_gains  = nil,
		//
		reverb_bus    = nil,
		reverb_gain   = 0.1,
		//
		sub_bus       = nil,
		sub_gain      = 0.5,
		//
		gain          = 1,
		// there needs to be a distance set for all sources
		dist          = 1
		|

		var in;
		var gain_i;
		var sub_level;

		in = SoundIn.ar(in_chan);

		sub_level =  (0.75/(max(0,dist)+1.0))*(0.75/(max(0,dist)+1.0));

		for (0, ~nIndividualSends-1,
			{arg cnt;

				gain_i = In.kr(individual_gains + cnt, 1);

				Out.ar(send_bus + cnt, (in * gain) * gain_i);

				// sub and reverb are added according to all spatial sends
				Out.ar(sub_bus, sub_level*(in * gain * gain_i * sub_gain));
				Out.ar(reverb_bus, in * gain * gain_i * reverb_gain);

			}
		);

		for (0, ~nCommonSends-1,
			{arg cnt;

				gain_i = In.kr(common_gains + cnt);

				Out.ar(common_bus + (cnt), in * gain * gain_i);
			}
		);

	}
).add;


// The generic output module is equipped with a high pass and a delay

SynthDef(\output_module,
	{
		|
		audio_bus = nil,
		out_bus   = nil,
		delay     = 0,
		gain      = 1,
		hp_cutoff = 5
		|

		var out;

		out = HPF.ar(DelayN.ar(In.ar(audio_bus,1),0.3,delay),hp_cutoff);

		Out.ar(out_bus, gain*out);

}).add;


// The sub output module is equipped with a low pass and a delay

SynthDef(\sub_output_module,
	{
		|
		audio_bus = nil,
		out_bus   = nil,
		delay     = 0,
		gain      = 1,
		lp_cutoff = 100
		|

		var in, out;

		in  = DelayN.ar(In.ar(audio_bus,1),0.3,delay);
		out = LPF.ar(in, lp_cutoff);

		Out.ar(out_bus, gain*out);
}).add;




