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

o.numInputBusChannels  = 64;
o.numOutputBusChannels = 128;

o.maxLogins            = 2;

t = Server.remote(\hufo_remote, NetAddr("172.25.18.201", 65536), o);

)

// get information

t.makeWindow;

t.meter;

t.queryAllNodes();


