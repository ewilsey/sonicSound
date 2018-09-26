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
