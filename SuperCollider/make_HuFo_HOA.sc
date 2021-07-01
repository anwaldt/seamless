/*

Make HOA decoders for the HuFo System
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
~spkrPos = TabFileReader.read(~root_DIR++"../speakerpositions/HufoAmbisonics_resorted.txt",true).postcs;

	~spkrPos.do({arg e; e.add("\"spkr\"")});
};

// 2: or define speaker positions:
~spkrPos = [
[ -5.888, 2.217, -0.059, "spkr" ],
[ -5.888, 2.217, -0.75, "spkr" ],
[ -5.286, 2.645, 1.312, "spkr" ],
[ -4.473, 3.116, -0.059, "spkr" ],
[ -4.473, 3.116, -0.75, "spkr" ],
[ -2.925, 3.757, -0.059, "spkr" ],
[ -2.925, 3.757, -0.75, "spkr" ],
[ -1.896, 4.022, 1.312, "spkr" ],
[ -1.289, 4.123, -0.059, "spkr" ],
[ -1.289, 4.123, -0.75, "spkr" ],
[ 0.385, 4.201, -0.059, "spkr" ],
[ 0.385, 4.201, -0.75, "spkr" ],
[ 1.861, 4.035, 1.312, "spkr" ],
[ 2.048, 3.99, -0.059, "spkr" ],
[ 2.048, 3.99, -0.75, "spkr" ],
[ 3.65, 3.495, -0.059, "spkr" ],
[ 3.65, 3.495, -0.75, "spkr" ],
[ 5.142, 2.732, -0.059, "spkr" ],
[ 5.142, 2.732, -0.75, "spkr" ],
[ 5.306, 2.632, 1.312, "spkr" ],
[ 6.518, 1.692, -0.059, "spkr" ],
[ 6.518, 1.692, -0.75, "spkr" ],
[ 5.888, -2.217, -0.059, "spkr" ],
[ 5.888, -2.217, -0.75, "spkr" ],
[ 5.286, -2.645, 1.312, "spkr" ],
[ 4.473, -3.116, -0.059, "spkr" ],
[ 4.473, -3.116, -0.75, "spkr" ],
[ 2.925, -3.757, -0.059, "spkr" ],
[ 2.925, -3.757, -0.75, "spkr" ],
[ 1.896, -4.022, 1.312, "spkr" ],
[ 1.289, -4.123, -0.059, "spkr" ],
[ 1.289, -4.123, -0.75, "spkr" ],
[ -0.385, -4.201, -0.059, "spkr" ],
[ -0.385, -4.201, -0.75, "spkr" ],
[ -1.861, -4.035, 1.312, "spkr" ],
[ -2.048, -3.99, -0.059, "spkr" ],
[ -2.048, -3.99, -0.75, "spkr" ],
[ -3.65, -3.495, -0.059, "spkr" ],
[ -3.65, -3.495, -0.75, "spkr" ],
[ -5.142, -2.732, -0.059, "spkr" ],
[ -5.142, -2.732, -0.75, "spkr" ],
[ -5.306, -2.632, 1.312, "spkr" ],
[ -6.518, -1.692, -0.059, "spkr" ],
[ -6.518, -1.692, -0.75, "spkr" ],
[ -0.3, 0, 2.017, "spkr" ]
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

~hoaAmbiHelper.specifySpeakersAsXYZ(~spkrPos);

~hoaAmbiHelper.setSweetSpot(~hoaAmbiHelper.centerOfGravity + [0.0,0.0,0.0]);

~hoaAmbiHelper.makeAmbiDecoderSpeakerPositionFile();

~hoaAmbiHelper.makeAmbiDecoderAllradRunFile(order:3, chanOrder:"ACN", chanNorm:"N3D");

// Don't use wrapper class
// ~hoaAmbiHelper.makeWrapperClass(~path, 5);

 