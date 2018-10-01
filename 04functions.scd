// define an addition function.
// assign that function to the envir variable 'a'
(
a = {
	arg in1=0, in2=2;
	var result;
	result = in1 + in2;
	result
}
)

// what is 'a'
a.dump

// evaluate 'a' with default values
a.value;

// evaluate 'a' replacing `in1` -> 40+2 = 42
a.value(40);

// evluate 'a' replacing `in1' and `in2` -> 40+60=100
a.value(40, 60)


// pass the return value to another variable
b = a.value(23, 42)
b


/*
What is the difference between arg's and var's in SC?
*/

// pyramid based signal flow
(
{
	var sig;

	// initialize sig with the output is SinOsc
	sig = SinOsc.ar(
		300,
		mul: SinOsc.ar(
			1,
			phase: 0,
			mul: SinOsc.ar(
				0.67,
				phase: 0,
				mul: 0.5,
				add: 0.5),
			add: 0.5
		)
	);

	// output sig (sounds like: ET)
	sig
}.play;
)


// variable based signal flow
(
{
	var sig, mod;

	// initialize sig with the output is SinOsc
	sig = SinOsc.ar(300);
	// multiply sig by an amp mod sinosc
	mod = SinOsc.ar(1, phase: 0, mul: 0.5, add: 0.5);
	mod = mod * SinOsc.ar(0.67, phase: 0, mul: 0.5, add: 0.5);

	sig = sig * mod;

	// output sig  (sounds like: slower ET)
	sig
}.play;
)


///////////////////////////////////////////////

// use arguments for values, objects, or data that may change between instanciations or through external means
(
a = {
	arg carrFreq = 300;
	var sig, mod;

	// initialize sig with the output is SinOsc
	sig = SinOsc.ar(carrFreq);
	// multiply sig by an amp mod sinosc
	mod = SinOsc.ar(1, phase: 0, mul: 0.5, add: 0.5);
	mod = mod * SinOsc.ar(0.67, phase: 0, mul: 0.5, add: 0.5);

	sig = sig * mod;

	// output sig
	sig
}.play;
)

a.set(\carrFreq, 600)

// To set an arguments value in an existing Synth,
// reference the synth,
// utilize the `.set()` method
// specify the argument to change and a value
a.set(\carrFreq, 600);
a.set(\carrFreq, 1200);
a.set(\carrFreq, 2400);

/*
Tour of UGens
*/

// To look up documentation, place your cursor on a word and type "cmd + d" or "cntrl + d"
SinOsc



// Look Up "Tour of UGens"
Tour of UGens





///////////////////////////////////////////

// noise driven input freq
(
a = {

	var sig, carrFreq;

	carrFreq = LFNoise0.kr(2);
	// carrFreq = LFNoise1.kr(2);
	// carrFreq = LFNoise2.kr(2);


	carrFreq = carrFreq.linlin(-1, 1, 100, 400).poll;

	sig = SinOsc.ar(carrFreq, mul: 0.8);

	// output sig
	sig
}.play;
)


/////////////////////////////////////////////


(
// sinosc
a = {
	arg freq = 200;
	var sig;

	sig = SinOsc.ar(freq, mul: 0.8);

	// output sig
	sig
};
a.plot(0.1);
a.play;
)


(
// blip
a = {
	arg freq = 200;
	var sig;

	sig = Blip.ar(freq, mul: 0.8);

	// output sig
	sig
};
a.plot(0.1);
a.play;
)

(
a = {
	arg freq = 200;
	var sig;

	sig = Saw.ar(freq, mul: 0.8);

	// output sig
	sig
};
a.plot(0.1);
a.play;
)

(
a = {
	arg freq = 200;
	var sig;

	sig = Pulse.ar(freq, width: MouseX.kr(0,1), mul: 0.8);

	// output sig
	sig
};
a.plot(0.1);
a.play;
)

(
a = {
	arg freq = 200;
	var sig;

	sig = Klang.ar(`[ [freq*1, freq*2, freq*4], [0.3, 0.3, 0.3], nil], mul: 0.8);

	// output sig
	sig
};
a.plot(0.1);
a.play;
)


(
a = {
	arg freq = 200;
	var sig;

	sig = LFTri.ar(freq, width: MouseX.kr(0,1), mul: 0.8);

	// output sig
	sig
};
a.plot(0.1);
a.play;
)


(
a = {
	arg freq = 200;
	var sig;

	sig = LFPar.ar(freq, width: MouseX.kr(0,1), mul: 0.8);

	// output sig
	sig
};
a.plot(0.1);
a.play;
)

//plot
(
a = {
	SinOsc.ar(400 + SinOsc.ar(240).linlin(-1,1,-300,800))
};

a.plot(0.1);
a.play;
)