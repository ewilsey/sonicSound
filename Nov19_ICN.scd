(
OSCdef(\test,{
	arg ...args;
	args.postln;
},
)
)

a = NetAddr("127.0.0.1", 8001)

a.sendMsg(\test,2)

// 127.0.0.1 => internal IP or Loopback IP address
// -> Ports 0-99999  specific location in an IP address



OSCFunc