// create an audio bus for mic synth
~mic = Bus.audio();


// basic input synth
(
SynthDef(\in, {
	arg micIn = 0, outBus = 0;
	var sig;

	sig = SoundIn.ar(micIn);
	sig = Normalizer.ar(sig, -3.dbamp);
	sig = DelayC.ar(sig, 1, 1);

	Out.ar(outBus, sig);

}).add;
)

Synth(\in, [\outBus, ~mic]);


// create a effects synth
(
SynthDef(\poppingAudio, {
	arg inBus = 0, outBus = 0, popRate = 10;
	var sig;

	sig = In.ar(inBus);

	sig = sig * Linen.kr(Dust.ar(popRate).round);

	sig = Limiter.ar(sig, 1.0);

	Out.ar(outBus, sig);
}).add;
)

Synth(\poppingAudio, [\inBus, ~mic]);
////////////////////////////////////

// create an audio bus for mic synth
// ~mic = Bus.audio();
~fx = Bus.audio;


// basic input synth
(
SynthDef(\in, {
	arg micIn = 0, outBus = 0;
	var sig;

	sig = SoundIn.ar(micIn);
	sig = Normalizer.ar(sig, -3.dbamp);
	sig = DelayC.ar(sig, 1, 1);

	Out.ar(outBus, sig);

}).add;
)

// create a effects synth
(
SynthDef(\masterOut, {
	arg inBus = 0, outBus = 0, popRate = 10;
	var sig;

	sig = In.ar(inBus);

	sig = Limiter.ar(sig, 1.0);

	Out.ar(outBus, sig);
}).add;
)

~micSynth = Synth(\in, [\outBus, ~fx]);

~masterOut = Synth(\masterOut, [\inBus, ~fx], addAction: 'addToTail');



(
SynthDef(\selfRegulator, {
	arg inBus = 0, outBus = 0;
	var sig, ampVal;

	sig = In.ar(inBus);

	ampVal = (Amplitude.kr(sig, 0.01, 1)*1).clip(0, 1);

	sig = sig * (1-ampVal).poll;


	// adds signal to existing contents of bus
	// Out.ar(outBus, sig);

	// replace the contents of a bus (useful to revent mixing of contents on bus)
	ReplaceOut.ar(outBus, sig);
}).add;
)

(
~regulator = Synth(\selfRegulator,
	[\inBus, ~fx, \outBus, ~fx],
	target: ~masterOut,
	addAction: 'addBefore');
)

~regulator.free
///////////////////////////////////////////////////////////

// create an audio bus for mic synth
~mic = Bus.audio();


// basic input synth
(
SynthDef(\in, {
	arg micIn = 0, outBus = 0;
	var sig;

	sig = SoundIn.ar(micIn);
	sig = Normalizer.ar(sig, -3.dbamp);
	sig = DelayC.ar(sig, 1, 1);

	Out.ar(outBus, sig);

}).add;
)

// create a effects synth
(
SynthDef(\poppingAudio, {
	arg inBus = 0, outBus = 0, popRate = 10;
	var sig;

	sig = In.ar(inBus);

	sig = sig * Linen.kr(Line.kr(1,0,0.1), doneAction: 2);

	sig = Limiter.ar(sig, 1.0);

	Out.ar(outBus, sig);
}).add;
)



// old way
Synth(\poppingAudio, [\inBus, ~mic], );
Synth(\in, [\outBus, ~mic]);




// specify position in node group
Synth(\in, [\outBus, ~mic]);
Synth(\poppingAudio, [\inBus, ~mic], addAction: 'addToTail' );
(
t.stop;
t = Task({inf.do({
	Synth(\poppingAudio, [\inBus, ~mic], addAction: 'addToTail' );
	1.5.rand.wait;
})}).play;
)

///////////////////////////////////////////////////////

// we can use InFeedback to grabn information from a bus,
// even if that information occurs later in the node tree.



// create an audio bus for mic synth
~mic = Bus.audio();


// basic input synth
(
SynthDef(\in, {
	arg micIn = 0, outBus = 0;
	var sig;

	sig = SoundIn.ar(micIn);
	sig = Normalizer.ar(sig, -3.dbamp);
	sig = DelayC.ar(sig, 1, 1);

	Out.ar(outBus, sig);

}).add;
)

// create a effects synth
(
SynthDef(\poppingAudio, {
	arg inBus = 0, outBus = 0, popRate = 10;
	var sig;

	sig = InFeedback.ar(inBus);

	sig = sig * Linen.kr(Line.kr(1,0,0.1), doneAction: 2);

	sig = Limiter.ar(sig, 1.0);

	Out.ar(outBus, sig);
}).add;
)


// Notice that popping is now first, but InFeedback still grabs the signal.
Synth(\in, [\outBus, ~mic]);
Synth(\poppingAudio, [\inBus, ~mic], );

(
t = Task({
	inf.do({
		Synth(\poppingAudio, [\inBus, ~mic], );
		1.5.rand.wait;
})}).play;
)

////////////////////////////////////////////////

~fbBus = Bus.audio;

// use typical busses to create an internal feedback loop
// note: requires InFeedback to read from previous cycle on bus
(
SynthDef(\feedbackDelay, {
	arg micIn = 0;
	var sig, inSig, fbSig;

	inSig = SoundIn.ar(micIn);

	fbSig = InFeedback.ar(~fbBus);

	sig = Mix([inSig, fbSig]);

	sig = DelayC.ar(sig, 2, 2);

	Out.ar(~fbBus, sig);

	Out.ar(0, sig);
}).add;
)

Synth(\feedbackDelay)



(
SynthDef(\feedbackDelay_Interal, {
	arg micIn = 0;
	var sig, inSig, fbSig;

	inSig = SoundIn.ar(micIn);

	fbSig = LocalIn.ar(1);

	sig = Mix([inSig, fbSig]);

	Out.ar(0, sig);

	sig = DelayC.ar(sig, 2, 0.1);

	LocalOut.ar(sig * 0.7);

}).add;
)

Synth(\feedbackDelay_Interal)

//////////////////////////////////////////