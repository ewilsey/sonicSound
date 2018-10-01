"Are you ready to make a sweet musical baby together?".postln;


// Use this for bass  or find envelope to replace. SAVE
({
	SinOsc.ar(freq: MouseY.kr +( 200 * MouseX.kr), mul: 0.707).poll;
}.play;)


// simple amplitude modulation could be used for a beat.
({ SinOsc.ar( freq: 80 ) * SinOsc.kr(0.5).poll }.play;)

({
	var sig, noteEnv;
	noteEnv = Env.new(
		[57,57,0,0,65,65,0,0,47,47,0,0,57,57,0,0,57,57,0,0,65,65,0,0,47,47,0,0,57,57,0,0,57,57,0,0,65,65,0,0,47,47,0,0,57,57,0,0,57,57,0,0,65,65,0,0,47,47,0,0,57,57,0,0,57,57,0,0,65,65,0,0,47,47,0,0,57,57,0,0,57,57,0,0,65,65,0,0,47,47,0,0,57,57,0,0],
		[3, 0, 1,0, 3, 0,1,0, 3, 0,1,0, 3, 0,1,3, 0, 1,0, 3, 0,1,0, 3, 0,1,0, 3, 0,1,3, 0, 1,0, 3, 0,1,0, 3, 0,1,0, 3, 0,1,3, 0, 1,0, 3, 0,1,0, 3, 0,1,0, 3, 0,1,3, 0, 1,0, 3, 0,1,0, 3, 0,1,0, 3, 0,1,3, 0, 1,0, 3, 0,1,0, 3, 0,1,0, 3, 0,1]*0.13
	);
	noteEnv= EnvGen.kr( noteEnv ).poll;

	sig=SinOsc.ar( noteEnv.midicps, mul:0.7);
	Out.ar(0,sig!2);
}.play;)

