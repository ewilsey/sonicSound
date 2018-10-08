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

(
a.do( {
	arg item, idx;

	a[idx] = item ++ item;

	item.postln;
	idx.postln;
	"".postln;
} )
)

// ++(anArray)
(
var y, z;
z = [1, 2, 3, 4];
y = z ++ [7, 8, 9];
z.postln;
y.postln;
)


//.add(item)
(
// z and y are the same object
var y, z;
z = [1, 2, 3];
y = z.add(4);
z.postln;
y.postln;
)


// create an array from a number
100.do( {arg item, idx; idx.postln;} );

//Task

//square number generator

(
t=Task({
	50.do({arg i;
		i.squared.postln;
		0.5.wait;
	})
})
)

t.start;
t.pause;
t.resume;
t.reset;
t.stop;

/////////////////////////////
(
SynthDef(\simpleSine, {
	arg freq = 440;
	var sig;

	sig = SinOsc.ar(freq, mul: -3.dbamp);

	Out.ar(0, sig!2);
}).add;
)

a = Synth(\simpleSine)


(
r = Routine({

	a = Synth(\simpleSine);
	0.1.wait;

	13.do({ arg id;
		a.set(\freq, (id + 60).midicps );
		1.wait;
	});
	a.free;
})
)

r.play;




(
t = Task({
	a = Synth(\simpleSine);
	0.1.wait;

	13.do({ arg i;
		a.set(\freq, (i + 60).midicps );
		1.wait;
	});
	// a.free;
});
)


//////////////////////////////////////////////


(
SynthDef(\ping, {
	arg freq = 440, len = 1, amp = 1;

	var sig, env, pos;

	env = Env.new([0,1, 0.1, 0.1, 0], [0.1, 0.05, 0.75, 0.1]);
	env = EnvGen.kr( env, timeScale: len, doneAction: 2 );

	sig = SinOsc.ar( [freq, freq*1.01], mul: amp ) * env;
	sig = Mix(sig);

	pos = LFNoise2.ar(Rand.new(0.1, 10));

	sig = Pan2.ar( sig, pos );


	Out.ar(0, sig );
}).add
)

Synth(\ping)


(
t = Task({

	inf.do({
		var freq, len, amp;
		freq = rrand(200.0, 800.0).postln;
		len = rrand(1.0, 10.0).postln;
		amp = rrand(-24.0, -3.0).postln;
		"".postln;

		Synth(\ping, [\freq, freq, \len, len, \amp, amp.dbamp]);

		rrand(0.01, len).wait;
		// len.wait;
	})
})
)

t.start

t.pause
t.stop


///////////////////////////////////////////////



c = TempoClock.new( 4, 0 )

(
t = Task({

	inf.do({
		var freq, len, amp;
		freq = rrand(200.0, 800.0);
		len = rrand(0.2, 4.0);
		amp = rrand(-24.0, -3.0);

		Synth(\ping, [\freq, freq, \len, len, \amp, amp.dbamp]);

		// rrand(0.01, len).wait;
		1.0.wait;
	})
},
clock: c
)
)

t.start

// leave t running for the following

c = TempoClock.default;

// reference to default tempoclock
c

c.tempo

c.tempo = 120/60;

c.tempo = 240/60;

c.tempo = 30/60;









d = TempoClock.new( 0.5, 0 )

(
f = Task({

	inf.do({
		var freq, len, amp;
		freq = rrand(50.0, 200.0);
		len = rrand(0.2, 4.0);
		amp = rrand(-24.0, -3.0);

		Synth(\ping, [\freq, freq, \len, len, \amp, amp.dbamp]);

		// rrand(0.01, len).wait;
		1.0.wait;
	})
},
clock: d
).play;
)

d.tempo = 9/5

d.dump


/*Wednesday

Language-Side Scheduling and Sequencing

Scheduling with {}.fork & t.wait
.do{} loops
.stop
TempoClock()'s
Task({})
Routine({})
Sketch TODO: Write a short work that encapsulates your synth's as SynthDefs. Then utilize language-side scheduling to launch and alter synths algorithmically.*/
