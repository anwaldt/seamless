


SynthDef(\binaural_mono_encoder_3,
	{
		|
		in_bus  = nil,
		out_bus = 0,
		azim    = 0,
		elev    = 0,
		dist    = 2,
		gain    = 1
		|

		var sound, level, bform;

		sound = gain * In.ar(in_bus);

		// dist  = max(0.001,min(gain,100));

		level =  1;// (0.75/(max(0,dist)+1.0));

		azim = Lag.kr(azim,0.01);
		elev = Lag.kr(elev,0.01);
		dist = Lag.kr(dist,0.01);

		bform = HOASphericalHarmonics.coefN3D(3, azim, elev) * sound * level;

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

		var sound = gain * In.ar(in_bus);

		var level =  (1.0/(dist+1.0));

		Out.ar(out_bus, HOAEncoder.ar(3, sound, azim , elev));

}).add;


/*SynthDef(\hoa_decoder_EN325, {

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

}).add;*/



/*SynthDef(\hoa_decoder_HUFO, {

|in_bus = 0|


Out.ar(0,FaustHUFOHOA3.ar(
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

}).add;*/




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




/*SynthDef(\hoa_binaural_decoder_3,
{
|
in_bus  = 0,
out_bus = 0
|

var sig = HOABinaural.ar(3, In.ar(in_bus,16));
Out.ar(0, sig);

}).add;*/

