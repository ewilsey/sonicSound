s.boot
// Endlessly loop sound.

(
SynthDef(\micTest, {
	var inSig, sig;
	inSig= SoundIn.ar(0);
	sig = DelayC.ar(inSig, 4, 4);
	sig = Limiter.ar(sig, 0.9) ! 2;

	Out.ar(0,sig);
}).add
)

Synth(\micTest);