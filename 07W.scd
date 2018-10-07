// basic synchronous process
({
	"Hey dudes!".postln;
	1.0.wait;
	"Dudes!".postln;
	1.0.wait;
	"Hey... dudes?".postln;
	1.0.wait;

}.fork;)


//routine

//creat a routine
a=Routine.new({1.yield; 2.yield;})
a.dump;
//step through routine
a.next.postln;
a.next.postln;
//nothing left to step through
a.next.postln;