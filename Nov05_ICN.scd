// look up DAWs

//Octives are the doubling of a frequency
// Fourier Transform - FT
// Converts a time-domain into a frequency-domain signal.


//FFT-> Fast FT


~frame = 2048;
~sr = 44100;
~frame/ ~sr

//The length of a signal correlates to the number of bins in an FFT.


(
{
    var in, chain;
    in = WhiteNoise.ar(0.1);
    chain = FFT(LocalBuf(2048), in);
    IFFT(chain) // inverse FFT
}.play;
)

// inspecting it, we see that the chain is an FFT:
(
{
    var in, chain;
    in = WhiteNoise.ar(0.1);
    chain = FFT(LocalBuf(2048), in);
    chain.inspect;
    IFFT(chain) // inverse FFT
}.play;
)

(
{
    var in, chain;
    in = SinOsc.ar(SinOsc.kr(SinOsc.kr(0.08,0,6,6.2).squared, 0, 100, 800));
    chain = FFT(LocalBuf(2048), in);
    IFFT(chain)
}.play;
)

(
{
    var in, chain;
    in = SinOsc.ar(SinOsc.kr(SinOsc.kr(0.08,0,6,6.2).squared, 0, 100,800));
    //in = WhiteNoise.ar(0.2);
    chain = FFT(LocalBuf(2048), in);
    chain = PV_MagAbove(chain, 310);
    0.5 * IFFT(chain);
}.play;
)

(
{
    var in, chain;
    in = WhiteNoise.ar(0.2);
    chain = FFT(LocalBuf(2048), in);
    chain = PV_BrickWall(chain, SinOsc.kr(0.1));
    IFFT(chain)
}.play;
)

(
{
    var in, chain;
    in = WhiteNoise.ar(0.8);
    chain = FFT(LocalBuf(2048), in);
    chain = PV_RandComb(chain, 0.95, Impulse.kr(0.4));
    IFFT(chain)
}.play;
)

(
{
    var in, chain;
    in = WhiteNoise.ar(0.2);
    chain = FFT(LocalBuf(2048), in);
    chain = PV_RectComb(chain, 8, LFTri.kr(0.097,0,0.4,0.5),
        LFTri.kr(0.24,0,-0.5,0.5));
    IFFT(chain)
}.play;
)

(
{
    var in, chain;
    in = SinOsc.ar(LFNoise1.kr(5.2,250,400));
    chain = FFT(LocalBuf(2048), in);
    // moves in and out of freeze
    chain = PV_MagFreeze(chain, SinOsc.kr(0.2) );
    0.5 * IFFT(chain);
}.play;
)


// stereo example:

(
{
    var in, chain;
    in = SinOsc.ar(LFNoise1.kr([5.2, 3.3],250,400));
    chain = FFT({ LocalBuf(2048) } ! 2, in); // we need two buffers for stereo input.
    // moves in and out of freeze
    chain = PV_MagFreeze(chain, SinOsc.kr([0.2, 0.3]) );
    0.5 * IFFT(chain);
}.play;
)

///////////////////////////////////find on class notes 03
(
SynthDef(\testDer, {
	arg out = 0 , freq = 200, gate = 1;
	var sig, env;
	env = Env.adsr();
	env = EnvGen
	.kr(env, gate: gate);
	sig = LFTri.ar(freq) * env;

	Out.ar( out, sig!2);
}).add;
)

Synth(\testDer);

~bus = Bus.audio(s,2);
(Pdef(\test,
	Pbind(
		\instrument, \testDer,
		\note, Pseq([0,7,5,3,0], inf);

		\out, ~bus
	)
)
)
Pdef(\test).play

//////////////////////////////04 analysis

// analysis
// spectral centroid -> mean of freq spectrum

(
SynthDef(\specCent, {
	arg in = 0;
	var sig, chain, analysisVal;

	sig = SoundIn.ar(in);

	chain = FFT(LocalBuf(2048), sig);

	analysisVal = SpecCentroid.kr(chain);

	analysisVal.poll;

}).play;
)

/////////////////////////////// fundamental frequency

(
SynthDef(\fundFreq,{
arg in = 0;
var sig, freq, hasFreq;
	sig = SoundIn.ar(in);
	#freq, hasFreq = Pitch.kr(sig);
	freq.poll;
	hasFreq.poll;
}).play;
)

// output : 1 = freq 0 = noise


