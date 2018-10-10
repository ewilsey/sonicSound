(
SynthDef.new(\bRand, {
 	arg freq = 200, len = 0, amp = 0.2;

	var sig, env, pos;

	env = Env.new([0,1, 0.1, 0.1, 0], [0.1, 0.05, 0.75, 0.1]);
	env = EnvGen.kr( env, timeScale: len, doneAction: Done.freeSelf );

	sig = FSinOsc.ar( [freq, freq*1.01], mul: amp ) * env;

	pos = SinOsc.ar(Rand.new(0.1, 10)mul: -3.dbamp);

	sig = Pan2.ar( sig, pos );


	Out.ar(0, sig );
}).add;
)

Synth(\bRand)

c = TempoClock.new( 1, 1 )
(
t = Task({

	inf.do({
		var freq, len, amp;
		freq = rrand(200.0, 800.0).postln;
		len = rrand(1.0, 10.0).postln;
		amp = rrand(-24.0, -3.0).postln;
		"".postln;

		Synth(\bRand, [\freq, freq, \len, len, \amp, amp.dbamp]);

		rrand(0.01, len).wait;
		// len.wait;
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

c.tempo = 120/20;

c.tempo = 240/60;

c.tempo = 30/60;