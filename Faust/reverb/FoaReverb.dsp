import("stdfaust.lib");

// `rgxyz` = relative gain of lanes 1,4,2 to lane 0 in output (e.g., -9 to 9)
rgxyz = nentry("rgxyz",1,-9,9,0.01) ;

// `rdel`  = delay (in ms) before reverberation begins (e.g., 0 to ~100 ms)
rdel= nentry("rdel",2,0,100,0.01) ;

// * `f1`: crossover frequency (Hz) separating dc and midrange frequencies
f1    = nentry("f1",300,10,10000,0.1) ;

// * `f2`: frequency (Hz) above f1 where T60 = t60m/2 (see below)
f2 = nentry("f2",1000,10,10000,0.1) ;

// * `t60dc`: desired decay time (t60) at frequency 0 (sec)
t60dc=nentry("t60dc",3,0.01,7,0.01) ;

// * `t60m`: desired decay time (t60) at midrange frequencies (sec)
t60m=nentry("t60m",4,0.01,7,0.01) ;

// * `fsmax`: maximum sampling rate to be used (Hz)
fsmax=48000;

process =  _<: _,_ : re.zita_rev1_ambi(rgxyz,rdel,f1,f2,t60dc,t60m,fsmax) : _,_,_,_;
