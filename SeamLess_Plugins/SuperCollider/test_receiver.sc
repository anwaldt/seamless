/*

Test script for receiving OSC data from the control plugins.

*/


s.boot;


thisProcess.openUDPPort(9001);


// test incoming xyz control messages
(
~x_BUS = Bus.control(s,32);

OSCdef(\x,
	{|msg, time, addr, recvPort|
		var val;
		val = msg[2]/10;
		~x_BUS.setAt(msg[1]-1,val);
		msg.postln;
},'/source/pos/xyz', n);
)


// test incoming reverb control messages
(
OSCdef(\reverbgain,
	{|msg, time, addr, recvPort|
		var val;
		val = msg[1]/10;
		//~x_BUS.setAt(msg[1]-1,val);
		"-".postln;
},'/reverb/gain', n);
)


s.scope(16,~x_BUS.index,rate:'control');
 