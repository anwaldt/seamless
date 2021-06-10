#!/bin/bash

# build and copy jack standalone decoders for different orders

faust2jackconsole ../adt/decoders/EN325_DOME1.dsp;
cp ../adt/decoders/EN325_DOME1 .

faust2jackconsole ../adt/decoders/EN325_DOME2.dsp;
cp ../adt/decoders/EN325_DOME2 .

faust2jackconsole ../adt/decoders/EN325_DOME2.dsp;
cp ../adt/decoders/EN325_DOME2 .
