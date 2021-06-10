/*

Test script for receiving OSC data from the control plugins.

*/


s.boot;


(
~x_BUS = Bus.control(s,32);

OSCdef(\x,
	{|msg, time, addr, recvPort|
		var val;
		val = msg[2]/10;
		~x_BUS.setAt(msg[1]-1,val);

},'/source/pos/x', n);
)

s.scope(16,~x_BUS.index,rate:'control');
 