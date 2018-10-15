//we can use inFeedback to grab info from a bus, even if that info occurs later in the node tree.


// create an audio bus for mic synth

~mic = Bus.audio();


//basic input synth
(
SynthDef(\in,
{
	arg micIn = 0, outBus = 0;
		var sig;
		sig = SoundIn.ar(micIn);
		sig = Normalizer.ar(sig, -3.dbamp);
		sig = DelayC.ar(sig, 1, 1);

		Out.ar(outBus, sig);
}).add;
)

Synth(\in, [\outBus, ~mic]);

//creates an effects synth

(
SynthDef(\poppingAudio, {
	arg inBus = 0, outBus = 0, popRate = 1;
	var sig;
	sig = In.ar(inBus);

	sig = sig * (Dust.ar(popRate).ceil)
	sig = Limiter.ar(sig, 1.0);
	Out.ar(outBus, sig);
}).add;
)
Synth(\poppingAudio, [\inBUs, ~mic]);


//specify pos to node group
Synth(\in, [\outBus, ~mic], addAction: 'addToTail');

(
t=Task({inf.do({
	Synth(\poppingAudio, [\inBUs, ~mic], addAction: 'addToTail' );
	1.5.rand.wait;
})}).play;
)
// add to professor notes
~micSynth = Synth(\in,[\outBus, ~fx]);

~masterOut = Synth(\masterOut, [\inBus, ~fx], addAction: 'addToTail');

(
SynthDef(\selfRegulator, {
	arg inBus = 0, outBus =0;
	var sig, ampVal;
	sig = In.ar(inBus);
	ampVal = Amplitude.kr(sig, 0.5, 0.1);
	Out.ar(outBus, sig);
}).add;
)
~regulator = Synth(\selfRegulator,[\inBus, ~fx, \outBus, ~fx], target: ~masterOut, addAction: 'addBefore');
~regulator.free


(
t= Task({
	inf.do({
		synth(\poppingAudio, [\inBus, ~mic], );
		1.5.rand.wait;
})}).play;
)

(
Synth(\feedbackDelay, {
	arg micIn = 0;
	var sig, inSig, fbSig;
	inSig = SoundIn.ar(micIn);
	fbSig - InFeedback.ar(~fbBus);
	sig = Mix([inSig, fbSig]);
	sig = DelayC.ar(sig, 2,2);
	LocalOut.ar(sig);
	Out.ar(0,sig);

}).add;
)
Synth(\feedbackDelay)