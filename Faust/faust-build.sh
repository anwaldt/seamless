#!/bin/bash

faust2jackconsole reverb/FoaReverb.dsp

faust2supercollider -ks -sn -noprefix reverb/FoaReverb.dsp

mkdir -p ~/.local/share/SuperCollider/Extensions/Faust/
cp reverb/*.sc ~/.local/share/SuperCollider/Extensions/Faust/
cp reverb/*.so ~/.local/share/SuperCollider/Extensions/Faust/
cp reverb/*.schelp ~/.local/share/SuperCollider/Extensions/Faust/
