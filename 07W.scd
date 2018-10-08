// basic synchronous process
({
	"This".postln;
	1.0.wait;
	"is".postln;
	1.0.wait;
	"a".postln;
	1.0.wait;
	"process.".postln;
	1.0.wait;

}.fork;)


// Routine

// create a routine

a = Routine.new( { 1.yield; 2.yield; } );
a.dump;
// step through the routine
a.next.postln;
a.next.postln;
// nothing left to step through
a.next.postln;

(
Routine { arg inval;
	inval.postln;
}.value("hello routine");
)

(
var r, outval;
r = Routine.new({ arg inval;
    ("->inval was " ++ inval).postln;
    inval = 1.yield;
    ("->inval was " ++ inval).postln;
    inval = 2.yield;
    ("->inval was " ++ inval).postln;
    inval = 99.yield;
});

outval = r.next('a');
("<-outval was " ++ outval).postln;
outval = r.next('b');
("<-outval was " ++ outval).postln;
r.reset; "reset".postln;
outval = r.next('c');
("<-outval was " ++ outval).postln;
outval = r.next('d');
("<-outval was " ++ outval).postln;
outval = r.next('e');
("<-outval was " ++ outval).postln;
outval = r.next('f');
("<-outval was " ++ outval).postln;
)

(
r = Routine {


	0.postln; 1.wait;
	1.postln; 1.wait;
	2.postln; 1.wait;
	3.postln; 1.wait;
	4.postln; 1.wait;
	5.postln; 1.wait;
	6.postln; 1.wait;
	7.postln; 1.wait;
	8.postln; 1.wait;
	9.postln; 1.wait;

    // Wait half second before saying we're done
    0.5.wait;
    "done".postln;
}.play;
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
