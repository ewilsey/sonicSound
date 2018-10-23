// read a soundfile
s.reboot;
p = Platform.resourceDir +/+ "sounds/a11wlk01.wav";
p = "/Users/musick/Downloads/michael_musick.wav"
// load the soundfile into memory
b = Buffer.read(s, p);
b.dump
 // now play it
(
SynthDef(\playbackBuffer, {
	arg out = 0, bufnum;
    var sig;
 	sig = PlayBuf.ar(
		numChannels: 1,
		bufnum: bufnum,
		rate: BufRateScale.kr(bufnum) * MouseX.kr(-2, 100).poll(trig: 1.0),
		trigger: 1.0,
		startPos: 0.0,
		loop: 1.0,
		doneAction: 0
	);
 	Out.ar(out, sig);
 }).add;
)
// play the synth
x = Synth(\playbackBuffer, args: [\bufnum, b]);
x.set(\bufnum, 1);
 // ALWAYS FREE BUFFER AFTER FINISHING WITH IT!!!!
x.free; b.free;
 // now play it
(
x = SynthDef(\playbackBuffer, {
	arg out = 0, bufnum, length;
    var sig, sig2, pbRate;
 	pbRate = SinOsc.ar(
		LFNoise0.kr(LFNoise0.kr(1).linlin(-1,1,0.01,2)).linlin(-1,1, 0.5, 5)
	).linlin(-1,1,-2,4);
 	sig = PlayBuf.ar(
		numChannels: 1,
		bufnum: bufnum,
		rate: BufRateScale.kr(bufnum) * pbRate,
		trigger: Dust.kr(2),
		startPos: LFNoise0.kr(1).linlin(-1,1,0, length),
		loop: LFNoise0.kr(0.25).linlin(-1,1,0,1).round,
		doneAction: 0
	);
 	sig2 = PlayBuf.ar(
		numChannels: 1,
		bufnum: bufnum,
		rate: BufRateScale.kr(bufnum) * pbRate,
		trigger: Dust.kr(2),
		startPos: LFNoise0.kr(1).linlin(-1,1,0, length),
		loop: LFNoise0.kr(0.25).linlin(-1,1,0,1).round,
		doneAction: 0
	);
 	sig = Mix([sig, sig2]);
 	// sig = sig * SinOsc.ar(20, mul: 0.5, add: 0.5 );
	sig = FreeVerb.ar(sig, 0.2, 0.9, 0.1);
 	Out.ar(out, sig);
 }).add;
)
 x = Synth(\playbackBuffer, [\bufnum, b, \length, b.numFrames])
 x.free; b.free;

28  content/12-playBuffer/02-doWhenLoaded.scd
@@ -0,0 +1,28 @@
 // with an action function
// note that the vars are not immediately up-to-date
(
 b = Buffer.read(s, p,
	action: {
		arg buffer;
		("After update:" + buffer.numFrames).postln;
		x = { PlayBuf.ar(1, buffer, BufRateScale.kr(buffer)) }.play;
	}
);
("Before update:" + b.numFrames).postln;
 )
x.free; b.free;
 // synchronous and asynchronous execution
//
// -> synchronous, the line before finishes, then the next is executed.
// -> asynch, go do something and tell me when you finish

39  content/12-playBuffer/03-grainular.scd
@@ -0,0 +1,39 @@
s.boot;
 (
var winenv;
 // b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01-44_1.aiff");
// a custom envelope
winenv = Env([0, 1, 0], [0.5, 0.5], [8, -8]);
z = Buffer.sendCollection(s, winenv.discretize, 1);
 SynthDef(\buf_grain_test, { |out, gate = 1, amp = 1, sndbuf, envbuf, dur = 0.1|
    var pan, env, freqdev, sig, rate;
    // use mouse x to control panning
    pan = 0;
    env = EnvGen.kr(
        Env([0, 1, 0], [1, 1], \sin, 1),
        gate,
        levelScale: amp,
        doneAction: Done.freeSelf);
 	rate = MouseX.kr(0.1, 100).poll;
     sig = GrainBuf.ar(2, Impulse.kr(rate), dur, sndbuf, 1,
		MouseY.kr(0, 1).poll, 2, pan, envbuf) * env;
 	Out.ar(0, sig);
}).add;
)
 // use built-in env
x = Synth(\buf_grain_test, [\sndbuf, b, \envbuf, -1])
 // switch to the custom env
x.set(\envbuf, z)
x.set(\envbuf, -1);
 x.set(\dur, 0.03)
 x.set(\gate, 0); 