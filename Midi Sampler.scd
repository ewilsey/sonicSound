({
	var sig, note, freq;

	note = MouseX.kr(10, 127, warp: 0);
	note = note.floor.poll;
	freq = note.midicps;

	SinOsc.ar(freq, mul: 0.7);

}.play;
)