import("stdfaust.lib");

rgxyz = 1;
rdel=1;
f1    = 100;
f2 = 100;

t60dc=1;
t60m=1;
fsmax=16000;

process =  _<: _,_ : re.zita_rev1_ambi(rgxyz,rdel,f1,f2,t60dc,t60m,fsmax) : _,_,_,_;