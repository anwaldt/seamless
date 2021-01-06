/*

Make HOA decoders for the dome at TU Studio (EN324)
for different orders (up to 5), uing the ADT.

- adapted from SC readme: 'HOA Tutorial Exercise 15'

Henrik von Coler
2020-09-29

*/


// 1: Set the path to the ADT (included as submodule):
~path = "adt/";


// 2: Define speaker positions:
 ~spkrPos = [
[2.935,	   0.683203536311494,	-0.394169269060897,   "spkr"],
[2.323,	  -1.43690698812563,	-0.390794925867249,   "spkr"],
[0.353,	  -1.92919991891976,	-0.391549983428213,   "spkr"],
[-1.569,  -1.97842372028654,	-0.420759061634656,   "spkr"],
[-2.795,  -0.317988852989665,	-0.388378538581242,   "spkr"],
[-2.311,   2.07732531407415,	-0.374401259646808,   "spkr"],
[-0.180,   2.63561514195793,	-0.387275450185584,   "spkr"],
[2.082,	   2.50411369490646,	-0.387796569159885,   "spkr"],
[3.361,	  -0.678489304168774,	0.457008524195736,   "spkr"],
[1.272,	  -2.07738440797092,	0.464280478258089,   "spkr"],
[-0.958225067033267,  -2.31564587633701,	0.471263086091499,   "spkr"],
[-2.87971229898170,	  -1.45338587548411,	0.471727222064673,   "spkr"],
[-3.21134473418867,	   1.22244155762448,	0.483530388281136,   "spkr"],
[-1.64281846532226,	   2.71368448239637,	0.491084534471762,   "spkr"],
[1.08302108594581,	   3.01646357165161,	0.474987208559918,   "spkr"],
[3.02887264858921,	   1.75295210304142,	0.462589886477090,   "spkr"],
[1.06951776747793,	  -0.769659249591043,	1.32689727732329,   "spkr"],
[-0.715722376349737,  -0.900754021538079,	1.33190978398511,   "spkr"],
[-0.877372561723083,   0.848749747006298,	1.33639113095389,   "spkr"],
[0.883036843631414,	   1.05198939773575,	1.32727700192576,   "spkr"],
[1.12055182121983e-16, 0,	1.83000000000000,   "spkr"],
];

HOA

~hoaAmbiHelper = HOAAmbiDecoderHelper();

~hoaAmbiHelper.setAmbiToolboxPath(~path);

~hoaAmbiHelper.setSpeakerArrayName("HUFO_HOA");

~hoaAmbiHelper.specifySpeakersAsXYZ(~spkrPos);

~hoaAmbiHelper.setSweetSpot(~hoaAmbiHelper.centerOfGravity + [0.0,0.0,0.0]);

~hoaAmbiHelper.makeAmbiDecoderSpeakerPositionFile();

~hoaAmbiHelper.makeAmbiDecoderAllradRunFile(order:3, chanOrder:"ACN", chanNorm:"N3D");

// Don't use wrapper class
// ~hoaAmbiHelper.makeWrapperClass(~path, 5);