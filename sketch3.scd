(
SynthDef(\feedbackDelay, {
	arg micIn = 0;
	var sig, inSig, fbSig;

	inSig = SoundIn.ar(micIn);

	fbSig = InFeedback.ar(~fbBus);

	sig = Mix([inSig, fbSig]);

	sig = DelayC.ar(sig, 2, 1);

	Out.ar(~fbBus, sig);

	Out.ar(0, sig * 0.7);
}).add;
)

Synth(\feedbackDelay)