// Envelopes

// Envelopes wrap data in some sort of controlling "thing"



// starting with a basic sin example (no-enveolopes)
// Envelopes

// Envelopes wrap data in some sort of controlling "thing"



// starting with a basic sin example (no-enveolopes)
(
{
	var sig;

	sig = SinOsc.ar(200);

	Out.ar( 0, sig ! 2 );

}.play;
)


// use a `line` UGen to change amplitide
(
{
	var sig, env;

	env = Line.kr( start: 0, end: 1.0, dur: 4 );

	sig = SinOsc.ar(200) * env;

	Out.ar( 0, sig ! 2 );

}.play;
)

// opposite
(
{
	var sig, env;

	env = Line.kr( start: 1, end: 0, dur: 4 );

	sig = SinOsc.ar(200) * env;

	Out.ar( 0, sig ! 2 );

}.play;
)


// XLine (exponential line generator)
(
{
	var sig, env;

	env = XLine.kr( start: 2, end: 1, dur: 4 ) - 1;

	sig = SinOsc.ar(200) * env;

	Out.ar( 0, sig ! 2 );

}.play;
)


// applied to freq (Might make a good intro?)
(
{
	var sig, freq1, freq2;

	freq1 = Line.kr( start: 400, end: 20, dur: 4 );
	freq2 = XLine.kr( start: 400, end: 20, dur: 4 );

	sig = SinOsc.ar( [freq1, freq2] );
	sig.size.postln;

	Out.ar( 0, sig );

}.play;

)


// We can use envelopes to drive short time frames as well
// look at Decay

// impulse without decay
({
	var sig;
	sig = Impulse.ar(MouseX.kr(0.01, 100)) * 0.7;
	Out.ar(0, sig!2);
}.play;)

({
	var sig, freq;

	freq = MouseX.kr(0.01, 100);

	sig = Impulse.ar(freq) * 0.7;
	sig = Decay.ar(in: sig, decayTime: freq.linexp(0.01, 100, 1, 0.0001), mul: SinOsc.ar(400));



	Out.ar(0, sig!2);
}.play;) //why is this inconsistent?

// Linear Envelopes (or envelopes over time)

({
	var sig, env;

	env = Linen.kr(
		//gate: Line.kr(1,0,0.01),
		gate: MouseButton.kr(0,1,0),
		attackTime: 0.1,
		susLevel: 0.707,
		releaseTime: 0.5
	);

	sig = SinOsc.ar(400) * env;

	Out.ar(0, sig!2);
}.play;)



// lets look at more codified envelopes

// for all other envelopes, we need a seperate UGen and envelope specification
// UGEN -> EnvGen.ar/kr
// Specification comes from the `Env` class.

Env


({
	var sig, env;

	env = Env.perc(
		attackTime: 0.1,
		releaseTime: 0.5,
		level: 1.0,
		curve: -3
	);

	env = EnvGen.kr(env, gate: MouseButton.kr(0,1,0), levelScale: 0.707 );


	sig = SinOsc.ar(400) * env;

	Out.ar(0, sig!2);
}.play;)

// Env.linen is == in many ways to Env.asr
({
	var sig, env;

	env = Env.linen(
		attackTime: 0.1,
		sustainTime: 0.5,
		releaseTime: 0.5,
		curve: 0
	);

	env = EnvGen.kr(env, gate: MouseButton.kr(0,1,0), levelScale: 0.707 );


	sig = SinOsc.ar(800) * env;

	Out.ar(0, sig!2);
}.play;)



({
	var sig, env;

	env = Env.asr(
		attackTime: 0.1,
		sustainLevel: 1,
		releaseTime: 0.5,
		curve: 0
	);

	env = EnvGen.kr(env, gate: MouseButton.kr(0,1,0), levelScale: 0.707 );


	sig = SinOsc.ar(400) * env;

	Out.ar(0, sig!2);
}.play;)





// ADSR (Sounds kind of like a xylophone maybe?)I like this one.
({
	var sig, env;

	env = Env.adsr(
		attackTime: 0.01,
		decayTime: 0.5,
		sustainLevel: 0.01,
		releaseTime: 0.5,
		peakLevel: 1
	);

	env = EnvGen.kr(env, gate: MouseButton.kr(0,1,0), levelScale: 0.707 );


	sig = SinOsc.ar(200) * env;

	Out.ar(0, sig!2);
}.play;)

// Custom Envs (Does not seem to end, have not adujusted from MM example.)

(
a = {
	arg gate = 1;
	var sig, env;

	env = Env.new(
		levels: [0,    1,  0.1,    0.8,   0.1,  0.6,     0],
		times:    [0.01,  1,   0.5,    0.5,   2,    0.01],
		curve: [4, -4, 0, 4, -4, 0],
		releaseNode: 1
	);

	env = EnvGen.kr(env, gate: gate, levelScale: 0.707 );


	sig = SinOsc.ar(400) * env;

	Out.ar(0, sig!2);
}.play;)

a.set(\gate, 0)


//////// Makes button push do a sci-fi fade-out.

(
a = {
	arg gate = 1;
	var sig, env;

	env = Env.new(
		levels: [0,    1,  0.1, 0.8,  0],
		times:    [0.01, 0.5, 0.5, 0.01],
		curve: [4, -4, 0, 4]
	);

	env = EnvGen.kr(env, gate: MouseButton.kr(0,1,0), levelScale: 0.707 );


	sig = SinOsc.ar(400) * env;

	Out.ar(0, sig!2);
}.play;)

a.dump


// What happens to a synth after the envelope finishes?

({
	var sig, env;

	env = Env.linen(
		attackTime: 0.1,
		sustainTime: 1,
		releaseTime: 0.5,
		curve: 0

	);

	env = EnvGen.kr(env, gate: 1, levelScale: 0.1, doneAction: 2);


	sig = SinOsc.ar(400) * env;

	Out.ar(0, sig!2);
}.play;)


({
	var sig;
	sig=SinOsc.ar(0.1).linlin(-1,1,0,0.1);
	Out.ar(5,sig);
}.play;)


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

	sig=Blip.ar(MouseX.kr(0,100).poll, numharm: MouseY.kr(0,80).poll, mul: 0.7);
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
	freq= LFNoise2.ar(1).poll;

	sig=SinOsc.ar(freq, mul:0.7);

	Out.ar(0, sig!2);
}.play;)


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
		maxdelaytime:1,
		delaytime:MouseX.kr(0,0.1).poll,
		decaytime:MouseY.kr(0,1000).poll
	)+ in;
	sig = Limiter.ar (sig, 0.9);

	Out.ar(0,sig!2);
}.play;)


//hw fix

//env= Xline.kr(2.0,1,10)-1;
env=Env.new([2,1,1]);