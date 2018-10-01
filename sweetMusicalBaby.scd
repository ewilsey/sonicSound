(
a={
	var freq,sig;
	freq = LFNoise0.kr (6,182,311);
	sig = SinOsc.ar(freq);
	Out.ar(0, sig!2);
}.play;); // plays random musical tones for 20 seconds.

(
b={
	var sig, note, freq;

	note = MouseX.kr(10, 127, warp: 2); //changing warp alters sound, moving MouseX changes note and tone.
	note = note.floor.poll;
	freq = note.midicps;

	SinOsc.ar(freq, mul: 0.7);

}.play;
) //Adds a scratchy robot sound.




       