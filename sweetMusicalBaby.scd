(
a={
	var env,freq,sig;
	env= Xline.kr(2.0,1,10)-1;
	freq = LFNoise0.kr (6,182,311);
	sig = SinOsc.ar(freq);
	Out.ar(0, sig!2);
}.play;)

; // plays random musical tones for 20 seconds.

(
b={
	var sig, note, freq;

	note = MouseX.kr(10, 127, warp: 2, lag:0.2); //changing warp alters sound, moving MouseX changes note and tone.
	note = note.floor.poll;
	freq = note.midicps;

	SinOsc.ar(freq, mul: 0.7);
	Out.ar(0,sig!2);

}.play;)
//Adds a scratchy robot sound.




       