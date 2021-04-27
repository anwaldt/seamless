/*

sprawl_SERVER_CTL.sc

Examples for connecting to the remote
server for monitoring.

Henrik von Coler
2021-01-18

*/

// connect to the sprawl server

(

o = ServerOptions.new;
o.maxLogins = 2;

o.numInputBusChannels  = 32;
o.numOutputBusChannels = 64;

// 57110
// 58010
t = Server.remote(\sprawl_remote, NetAddr("130.149.23.24", 65536), o);

)

// get information

t.makeWindow;

t.meter;

t.queryAllNodes();
