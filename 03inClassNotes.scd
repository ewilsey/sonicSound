// Amplitude mod example 1 SCI-FI potential here.
(
{
	SinOsc.ar( MouseX.kr(80, 320) ) *
	SinOsc.ar( MouseY.kr(0.01, 400), mul: 0.5, add: 0.5 );
}.play;
)



// Frequency Modulation (FM) Example 1 SCI-FI weapon potential. Keep short -> Somewhat annoying.
(
{
	// a carrier frequency is multiplied by a modulation frequency
	SinOsc.ar( 200 + (SinOsc.ar(MouseX.kr(0, 100).poll, mul: 0.5) * MouseY.kr(0,100) ) ) ;
}.play;
)

// a carrier frequency is multiplied by a modulation frequency

// This top Example has Too-Much Modulation  (DO NOT USE) It Sounds bad.
({
	SinOsc.ar( SinOsc.ar(200, mul: 50, add: 100) + (SinOsc.ar(MouseX.kr(0, 100).poll, mul: 0.5) * SinOsc.ar(40, mul: 50, add: 50) ) ) ;}.play;)

// Better modulation example
(
{
	SinOsc.ar(200) * SinOsc.ar(100, mul: 0.5, add: 0.5)
}.play;
)

// Using variables to control signal flow
(
{
	var carr, mod, outputSig;

	carr = SinOsc.ar(400);
	mod = SinOsc.ar(100, mul: 0.5, add: 0.5);

	outputSig = carr * mod;
}.play;
)

// Using arguments for single pieces of data
(
{
	arg carrFreq = 400;
	var carr, mod, outputSig;

	carr = SinOsc.ar(carrFreq);
	mod = SinOsc.ar(100, mul: 0.5, add: 0.5);

	outputSig = carr * mod;
}.play;
)


// in SC a-z are set aside as global "environment variables"
c = 300;
c // <- execute this line to get back the value in c

// define your own global envrionemnt variable with '~'
~myVar = "Michael Musick is tired";
~myVar

// Use an env variable to store a synth instance
(
a = {
	arg carrFreq = 400;
	var carr, mod, outputSig;

	carr = SinOsc.ar(carrFreq);
	mod = SinOsc.ar(100, mul: 0.5, add: 0.5);

	outputSig = carr * mod;
}.play;
)

// change arguments of an active synth instance
a.set(\carrFreq, 100)
// show that 'a' is an instance of a synth
a.dump

(
{
	var sig;

	sig = SinOsc.ar(300);

	// multi-channel expansion (the easy way)
	sig ! 2;
}.play;
)


(
{
	var sig;

	sig = SinOsc.ar(300);

	// multi-channel array (explicit) with 2 channels
	[sig, sig];

}.play;
)


// sep left/right (Loud)
(
{
	var left, right;

	left = SinOsc.ar(200);

	right = Saw.ar(210, mul: 0.707);

	[left, right]
}.play;
)



// correct way of handling output
(
{
	var left, right;

	left = SinOsc.ar(200);

	right = Saw.ar(210, mul: 0.707);

	// Out.ar(0, [left, right]);
	Out.ar(0, right);
	Out.ar(1, left);
}.play;
)

// correct way of handling panning (FUN) Might be able to use?
(
{
	var sig;


	sig = Saw.ar(210, mul: 0.707);
	sig = Pan2.ar( sig, MouseX.kr(-1,1));

	Out.ar(0, sig);

}.play;
)