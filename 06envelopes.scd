({
	var sig;
	sig=SinOsc.ar(0.1).linlin(-1,1,0,0.1);
	Out.ar(5,sig);
}.play)


({
	var sig;
	sig=SinOsc.ar(0.1).range(0,10);
	Out.ar(5,sig);
}.play)



({
	var sig;
	sig=SinOsc.ar(0.2, mul: 10);
	sig=sig.clip(1,2);
	Out.ar(5,sig);
}.play)


// Clock Ugens

// impulse is a steady sample generator (steady meaning equal time between impulses)
({
	var sig;
	sig=Impulse.ar(MouseX.kr(0,100), mul:0.7);

	Out.ar(0, sig!2);

}.play;)


//band limited impulse generator
({
	var sig;

	sig=Blip.ar(MouseX.kr(0,100).poll, numharm: MouseY.kr(0,2000).poll, mul: 0.7);
	Out.ar(0,sig!2);
}.play;)


//Dust
//dust is an impulse generator that creates x-number of impulse per second.
// these are not periodic

({
	var sig;

	sig= Dust.ar(MouseX.kr(0,1000).poll, mul:0.7);
	Out.ar(0, sig!2);
}.play;)


//LFNoise;
//creates low freq noise values
//0-step
//1-linear ramp
//2 - exp ramp

({
	var freq, sig;


	//freq= LFNoise0.ar(1).poll;
	//freq= LFNoise1.ar(1).poll;
	//freq= LFNoise2.ar(1).poll;

	sig=SinOsc.ar(freq, mul:0.7);

	Out.ar(0, sig!2);
}.play)


//envelopes Revisited
//twinkle twinkle
({
	var sig, noteEnv;
	noteEnv = Env.new(
		[60,60,0,0,60,60,0,0,67,67,0,0,67,67,0,0],
		[3, 0, 1,0, 3, 0,1,0, 3, 0,1,0, 3, 0,1]*0.2
	);
	noteEnv= EnvGen.kr( noteEnv ).poll;

	sig=SinOsc.ar( noteEnv.midicps, mul:0.7);
}.play;)

({
	var sig,env;
	env= Env.new(

		[0,1,0.3,0.7,0],
		[0.3,0.1,0.5,0.5],
		curve:[4,-4,4,-4],
		releaseNode:2

	);
	env= EnvGen.kr(env,gate:MouseX.kr(-1,1).poll).poll;
	sig = LFTri.ar(60.midicps, mul:env* 0.7);
	Out.ar(0,sig!2);

}.play;)

//holy shit hahahahaha
({
	var in, sig, dT;

	in = SoundIn.ar(0);
	sig = CombC.ar(
		in,
		maxdelaytime:10,
		delaytime:MouseX.kr(0,0.1).poll,
		decaytime:MouseY.kr(0,1000).poll
	)+ in;
	sig = Limiter.ar (sig, 0.9);

	Out.ar(0,sig!2);
}.play;)