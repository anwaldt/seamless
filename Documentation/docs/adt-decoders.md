# ADT Decoders

Standalone decoders for Ambisonics are built with the Ambisonics Decoder Toolbox and SC-HOA.

## Generate Matlab/Octave Code

The SC directory includes scripts for generating Matlab/Octave code to be used by the ADT, named: ``make_..._HOA.sc``

Changes in the speaker configuration are easiest applied in the arrays within these scripts.

The script generates scrips in the ADT directory:

    adt/examples/run_dec_EN325_DOME.m


## Run Matlab/Octave Code

Create the Faust files (.dsp) and use them to build the  SC classes by running:

   $ octave run_dec_EN325_DOME.m

Results will be located in

  adt/decoders


## Rund Faust build Script

Build the standalone decoders (JACK clients) by running the script in ``Standalone_Decoders/``:

  $ ./faust-build.sh
