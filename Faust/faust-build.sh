#!/bin/bash

faust2jackconsole reverb/FoaReverb.dsp

faust2supercollider -ks -sn -noprefix reverb/FoaReverb.dsp

cp reverb/*.sc ~/.local/share/SuperCollider/Extensions/Faust/
cp reverb/*.so ~/.local/share/SuperCollider/Extensions/Faust/
