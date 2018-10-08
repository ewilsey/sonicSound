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

(
Routine { arg inval;
	inval.postln;
}.value("hello routine");
)


//array in SC


//initialize an array
a=["ha", "hola", "hello"];
//see the array
a.postln;
// return the element index at 0
a[0]
//iterate over each item in the array
a.do({arg item, idx; item.postln; idx.postln; "".postln;})



//Task

(
t=Tasl({
	50.do({arg o;
		i.squared.postln;
		0.5.wait;
	})
})
)

/////////////////////////////
SynthDef(\ping,{
	arg freq = 200,len = 1, amp = 1;
	var sig, env;
	env=Env.new([0,1,0.3,0.3,0],[0.1,0.05,0.75,0.1]);
	env=EnvGen.kr(env, timescale: len, doneAction: 2);

	sig = SinOsc.ar (freq, mul: amp) * env;
	Out.ar(0, sig!2);
}).add

Synth(\ping)
s.plotTree


/*Wednesday

Language-Side Scheduling and Sequencing

Scheduling with {}.fork & t.wait
.do{} loops
.stop
TempoClock()'s
Task({})
Routine({})
Sketch TODO: Write a short work that encapsulates your synth's as SynthDefs. Then utilize language-side scheduling to launch and alter synths algorithmically.*/
