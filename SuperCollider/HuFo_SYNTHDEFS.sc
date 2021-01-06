
////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////

SynthDef(\double_lfo,
	{
		|
		run      = 0,
		dur      = 1,
		trig     = 0,
		dir      = pi,
		gain     = 1,
		offset   = 0,
		out_bus1 = nil,
		out_bus2 = nil
		|

		var ramp, x;

		ramp = Sweep.kr(trig, run / dur).linlin(0, 1, 0, dir, \minmax);

		x = (gain * sin(ramp)) + offset + 0.5;


		// var x = Sweep.kr(trig, rate);

		Out.kr(out_bus1,   x);
		Out.kr(out_bus2,   x * (-1));


}).add;


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


// adapted to stereo from vbap_test.scd
SynthDef(\kernel_shifter_stereo,
	{
		|
		in_bus1  = 0,
		in_bus2  = 1,
		out_bus  = 0,
		mod_1    = 0
		|


		for(0, 15, {arg idx;

			Out.ar(out_bus +idx,   In.ar(in_bus1) * sin((idx * mod_1) + idx));

		});

}).add;



// adapted to stereo from vbap_test.scd
SynthDef( \vbap_panner_stereo,
	{
		|
		in_bus1  = 0,
		in_bus2  = 1,
		out_bus  = 0,
		out_buf  = 0,
		azim_1   = -0.125, elev_1 = 0, sprd_1 = 0,
		azim_2   = 0.125, elev_2 = 0, sprd_2 = 0
		|

		// scaling
		azim_1 = (azim_1 * 360) - 180;
		azim_2 = (azim_2 * 360) - 180;

		sprd_1 = sprd_1 * 100;
		sprd_2 = sprd_2 * 100;

		Out.ar(out_bus, VBAP.ar(8, In.ar(in_bus1), out_buf, azim_1, elev_1, sprd_1));
		Out.ar(out_bus, VBAP.ar(8, In.ar(in_bus2), out_buf, azim_2, elev_2, sprd_2));

}).add;




SynthDef(\binaural_mono_encoder_3,
	{
		|
		in_bus  = nil,
		out_bus = 0,
		azim    = 0,
		elev    = 0,
		dist    = 3,
		gain    = 0.5
		|

		var sound = gain * In.ar(in_bus);

		var level =  (0.75/(max(0,dist)+1.0))*(0.75/(max(0,dist)+1.0));

		var bform = HOASphericalHarmonics.coefN3D(3, azim, elev) * sound * level;

		Out.ar(out_bus, bform);

}).add;




SynthDef(\hoa_mono_encoder_3,
	{
		|
		in_bus  = nil,
		out_bus = 0,
		azim    = 0,
		elev    = 0,
		dist    = 3,
		gain    = 1
		|

		var sound = gain * SoundIn.ar(in_bus);

		var level =  (1.0/(dist+1.0))*(1.0/(dist+1.0));

		Out.ar(out_bus, HOAEncoder.ar(3, sound, azim , elev));

}).add;


SynthDef(\hoa_stereo_encoder, {
	|
	in_bus1  = nil,
	in_bus2  = nil,
	out_bus  = 0,
	azim_1    = -45, elev_1 = 0,
	azim_2    =  45, elev_2 = 0
	|

	var sound1 = In.ar(in_bus1)*0.7;
	var sound2 = In.ar(in_bus2)*0.7;

	azim_1 = (azim_1 * (2 * pi)) -pi;
	azim_2 = (azim_2 * (2 * pi)) -pi;

	//elev1 = MouseY.kr(0,3.14);
	//elev2 = MouseY.kr(0,3.14);

	Out.ar(out_bus, HOAEncoder.ar(3, sound1,azim_1, elev_1));
	Out.ar(out_bus, HOAEncoder.ar(3, sound2,azim_2, elev_2));


}).add;




/*
SynthDef(\hoa_octa_decoder, {

|in_bus = 0|


Out.ar(0,Holzmarkt20203.ar(
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
*/




SynthDef(\hoa_binaural_decoder_3,
	{
		|
		in_bus  = 0,
		out_bus = 0
		|

		var sig = HOABinaural.ar(3, In.ar(in_bus,16));
		Out.ar(0, sig);

}).add;








// taken from vbap_test.scd
SynthDef( \speaker,
	{
		|
		in_bus  = nil,
		out_bus = nil,
		gain    = 1,
		delay   = 0
		|

		var input = In.ar(in_bus);

		Out.ar(out_bus, gain  * DelayL.ar(input, 1, delay));

}).add;




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




SynthDef(\send_module,
	{

		|
		in_chan       = nil,
		send_bus      = nil,
		common_bus    = nil
		send_gains    = nil,
		common_gains  = nil,
		gain          = 1
		|

		var in;
		var gain_i, gains;

		in = SoundIn.ar(in_chan);

		for (0, ~nSends,

			{arg cnt;

				gain_i = In.kr(send_gains + cnt);

				Out.ar(send_bus + (cnt),     in * gain * gain_i);
			}
		);

		for (0, ~nCommonSends,

			{arg cnt;

				gain_i = In.kr(common_gains + cnt);

				Out.ar(common_bus + (cnt),     in * gain * gain_i);
			}
		);

	}
).add;


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




