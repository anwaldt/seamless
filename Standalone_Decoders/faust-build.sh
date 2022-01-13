#!/bin/bash

# build and copy jack standalone decoders for different orders

faust2jackconsole ../adt/decoders/EN325_DOME1.dsp;
cp ../adt/decoders/EN325_DOME1 .

faust2jackconsole ../adt/decoders/EN325_DOME2.dsp;
cp ../adt/decoders/EN325_DOME2 .

faust2jackconsole ../adt/decoders/EN325_DOME3.dsp;
cp ../adt/decoders/EN325_DOME3 .



faust2jackconsole ../adt/decoders/HUFO_HOA1.dsp;
cp ../adt/decoders/HUFO_HOA1 .

faust2jackconsole ../adt/decoders/HUFO_HOA2.dsp;
cp ../adt/decoders/HUFO_HOA2 .

faust2jackconsole ../adt/decoders/HUFO_HOA3.dsp;
cp ../adt/decoders/HUFO_HOA3 .
