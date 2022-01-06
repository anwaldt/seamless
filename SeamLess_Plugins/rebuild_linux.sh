#!/bin/bash

cd SeamLess_Client/Builds/LinuxMakefile
rm -r build
make CONFIG=Release

cd ../../../
cd SeamLess_Main/Builds/LinuxMakefile
rm -r build
make CONFIG=Release
