"Are you ready to make a sweet musical baby together?".postln;


// Use this for bass  or find envelope to replace. SAVE
({
	SinOsc.ar(freq: MouseY.kr +( 200 * MouseX.kr), mul: 0.707).poll;
}.play;

)


