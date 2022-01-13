/*

Make HOA decoders for the dome at TU Studio (EN324)
for different orders (up to 5), uing the ADT.

- adapted from SC readme: 'HOA Tutorial Exercise 15'

Henrik von Coler
2020-09-29

*/



// get script's directory for relative paths
~root_DIR = thisProcess.nowExecutingPath.dirname++"/";

// 1: Set the path to the ADT (included as submodule):
~path = ~root_DIR++"../adt/";

// read speaker positions from txt file:
{
~spkrPos = TabFileReader.read(~root_DIR++"../speakerpositions/EN325-Dome/smallStudio_speaker_xyz.csv",true).postcs;

~spkrPos.do({arg e; e.add("\"spkr\"")});
};

// remove header:
//~spkrPos.removeAt(0);

for(0,~spkrPos.size-1,
	{arg i;
		//~sp[i].postln;
		~spkrPos[i].post;
		", ".postln
	}
);

// 2: Define speaker positions:
 ~spkrPos2 = [
[ 0.33,2.98,-0.450, "spkr" ],
[ -1.95,1.77,-0.450, "spkr" ],
[ -2.03,0.07,-0.450, "spkr" ],
[ -1.90,-1.79,-0.450, "spkr" ],
[ 0.01,-2.94,-0.450, "spkr" ],
[ 2.61,-1.70,-0.450, "spkr" ],
[ 2.67,0.01,-0.450, "spkr" ],
[ 2.65,1.66,-0.450, "spkr" ],
[ -1.07,3.27,0.410, "spkr" ],
[ -2.27,0.99,0.410, "spkr" ],
[ -2.32,-1.27,0.410, "spkr" ],
[ -1.25,-3.12,0.410, "spkr" ],
[ 1.43,-3.25,0.410, "spkr" ],
[ 2.81,-1.55,0.410, "spkr" ],
[ 2.95,1.25,0.410, "spkr" ],
[ 1.47,3.14,0.410, "spkr" ],
[ -0.92,0.97,0.865, "spkr" ],
[ -0.94,-0.95,0.862, "spkr" ],
[ 0.89,-1.00,0.853, "spkr" ],
[ 0.99,0.96,0.888, "spkr" ],
[ 0.00,0.00,1.296, "spkr" ],
];

for(0,~spkrPos2.size-1,
	{arg i;
		//~sp[i].postln;
		~spkrPos2[i].post;
		", ".postln
	}
);



~hoaAmbiHelper = HOAAmbiDecoderHelper();

~hoaAmbiHelper.setAmbiToolboxPath(~path);

~hoaAmbiHelper.setSpeakerArrayName("EN325_DOME");

~hoaAmbiHelper.specifySpeakersAsXYZ(~spkrPos2);

~hoaAmbiHelper.setSweetSpot(~hoaAmbiHelper.centerOfGravity + [0.0,0.0,0.0]);

~hoaAmbiHelper.makeAmbiDecoderSpeakerPositionFile();

~hoaAmbiHelper.makeAmbiDecoderAllradRunFile(order:3, chanOrder:"ACN", chanNorm:"N3D");

// Don't use wrapper class
// ~hoaAmbiHelper.makeWrapperClass(~path, 5);