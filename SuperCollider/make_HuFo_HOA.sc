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



~spkrPos = TabFileReader.read(~root_DIR++"../speakerpositions/Hufo_AmbiSpeakerPositions.txt",true).postcs;

~spkrPos.do({arg e; e.add("spkr")});



// 2: Define speaker positions:
~sp = [
[ -5.888, 2.217, 1.000, "spkr" ],
[ -4.473, 3.116, 1.000, "spkr" ],
[ -2.925, 3.757, 1.000, "spkr" ],
[ -1.289, 4.123, 1.000, "spkr" ],
[ 0.385, 4.201, 1.000, "spkr" ],
[ 2.048, 3.990, 1.000, "spkr" ],
[ 3.650, 3.495, 1.000, "spkr" ],
[ 5.142, 2.732, 1.000, "spkr" ],
[ 6.518, 1.692, 1.000, "spkr" ],
[ 5.888, -2.217, 1.000, "spkr" ],
[ 4.473, -3.116, 1.000, "spkr" ],
[ 2.925, -3.757, 1.000, "spkr" ],
[ 1.289, -4.123, 1.000, "spkr" ],
[ -0.385, -4.201, 1.000, "spkr" ],
[ -2.048, -3.990, 1.000, "spkr" ],
[ -3.650, -3.495, 1.000, "spkr" ],
[ -5.142, -2.732, 1.000, "spkr" ],
[ -6.518, -1.692, 1.000, "spkr" ],
[ -5.888, 2.217, 1.691, "spkr" ],
[ -4.473, 3.116, 1.691, "spkr" ],
[ -2.925, 3.757, 1.691, "spkr" ],
[ -1.289, 4.123, 1.691, "spkr" ],
[ 0.385, 4.201, 1.691, "spkr" ],
[ 2.048, 3.990, 1.691, "spkr" ],
[ 3.650, 3.495, 1.691, "spkr" ],
[ 5.142, 2.732, 1.691, "spkr" ],
[ 6.518, 1.692, 1.691, "spkr" ],
[ 5.888, -2.217, 1.691, "spkr" ],
[ 4.473, -3.116, 1.691, "spkr" ],
[ 2.925, -3.757, 1.691, "spkr" ],
[ 1.289, -4.123, 1.691, "spkr" ],
[ -0.385, -4.201, 1.691, "spkr" ],
[ -2.048, -3.990, 1.691, "spkr" ],
[ -3.650, -3.495, 1.691, "spkr" ],
[ -5.142, -2.732, 1.691, "spkr" ],
[ -6.518, -1.692, 1.691, "spkr" ],
[ -5.286, 2.645, 3.062, "spkr" ],
[ -1.896, 4.022, 3.062, "spkr" ],
[ 1.861, 4.035, 3.062, "spkr" ],
[ 5.306, 2.632, 3.062, "spkr" ],
[ 5.286, -2.645, 3.062, "spkr" ],
[ 1.896, -4.022, 3.062, "spkr" ],
[ -1.861, -4.035, 3.062, "spkr" ],
[ -5.306, -2.632, 3.062, "spkr" ],
[ 0.000, 0.000, 3.767, "spkr" ],
];



for(0,~spkrPos.size-1,
	{arg i;
		//~sp[i].postln;
		~spkrPos[i].post;
		", ".postln
	}
);




HOA;

~hoaAmbiHelper = HOAAmbiDecoderHelper();

~hoaAmbiHelper.setAmbiToolboxPath(~path);

~hoaAmbiHelper.setSpeakerArrayName("HUFO_HOA");

~hoaAmbiHelper.specifySpeakersAsXYZ(~sp);

~hoaAmbiHelper.setSweetSpot(~hoaAmbiHelper.centerOfGravity + [0.0,0.0,0.0]);

~hoaAmbiHelper.makeAmbiDecoderSpeakerPositionFile();

~hoaAmbiHelper.makeAmbiDecoderAllradRunFile(order:3, chanOrder:"ACN", chanNorm:"N3D");

// Don't use wrapper class
// ~hoaAmbiHelper.makeWrapperClass(~path, 5);

 