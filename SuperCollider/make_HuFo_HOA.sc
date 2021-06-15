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
~spkrPos = TabFileReader.read(~root_DIR++"../speakerpositions/HUFO/Hufo_AmbiSpeakerPositions_zero175_XYZ.txt",true).postcs;

~spkrPos.do({arg e; e.add("spkr")});
};

// 2: or define speaker positions:
~spkrPos = [
[ -5.89, 2.22, -0.75, "spkr" ],
[ -5.89, 2.22, -0.06, "spkr" ],
[ -5.29, 2.64, 1.31, "spkr" ],
[ -4.47, 3.12, -0.75, "spkr" ],
[ -4.47, 3.12, -0.06, "spkr" ],
[ -2.92, 3.76, -0.75, "spkr" ],
[ -2.92, 3.76, -0.06, "spkr" ],
[ -1.90, 4.02, 1.31, "spkr" ],
[ -1.29, 4.12, -0.75, "spkr" ],
[ -1.29, 4.12, -0.06, "spkr" ],
[ 0.39, 4.20, -0.75, "spkr" ],
[ 0.39, 4.20, -0.06, "spkr" ],
[ 1.86, 4.03, 1.31, "spkr" ],
[ 2.05, 3.99, -0.75, "spkr" ],
[ 2.05, 3.99, -0.06, "spkr" ],
[ 3.65, 3.50, -0.75, "spkr" ],
[ 3.65, 3.50, -0.06, "spkr" ],
[ 5.14, 2.73, -0.75, "spkr" ],
[ 5.14, 2.73, -0.06, "spkr" ],
[ 5.31, 2.63, 1.31, "spkr" ],
[ 6.52, 1.69, -0.75, "spkr" ],
[ 6.52, 1.69, -0.06, "spkr" ],
[ 5.89, -2.22, -0.75, "spkr" ],
[ 5.89, -2.22, -0.06, "spkr" ],
[ 5.29, -2.64, 1.31, "spkr" ],
[ 4.47, -3.12, -0.75, "spkr" ],
[ 4.47, -3.12, -0.06, "spkr" ],
[ 2.92, -3.76, -0.75, "spkr" ],
[ 2.92, -3.76, -0.06, "spkr" ],
[ 1.90, -4.02, 1.31, "spkr" ],
[ 1.29, -4.12, -0.75, "spkr" ],
[ 1.29, -4.12, -0.06, "spkr" ],
[ -0.39, -4.20, -0.75, "spkr" ],
[ -0.39, -4.20, -0.06, "spkr" ],
[ -1.86, -4.03, 1.31, "spkr" ],
[ -2.05, -3.99, -0.75, "spkr" ],
[ -2.05, -3.99, -0.06, "spkr" ],
[ -3.65, -3.50, -0.75, "spkr" ],
[ -3.65, -3.50, -0.06, "spkr" ],
[ -5.14, -2.73, -0.75, "spkr" ],
[ -5.14, -2.73, -0.06, "spkr" ],
[ -5.31, -2.63, 1.31, "spkr" ],
[ -6.52, -1.69, -0.75, "spkr" ],
[ -6.52, -1.69, -0.06, "spkr" ],
[ -0.30, 0.00, 2.02, "spkr" ]
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

 