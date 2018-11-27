Server.default.record;   ///Record
Server.default.stopRecording;    ///Stop


///Synth 1 Pink Noise
(
SynthDef("help-PinkNoise", { arg out=0;
    Out.ar(out,
        PinkNoise.ar(0.4)
    )
}).play;
)

///Synth 2 MIDI Cords
(
SynthDef.new(\iter,{
	arg freq = 40;
	var temp, sum, env;
	sum = 0;
	env = EnvGen.kr(
		Env.perc(0.01,5.75,1,-2),doneAction:2
	);
	10.do{
		temp = VarSaw.ar(
			freq * {Rand(0.99, 1.02)}!2,
			{Rand(0.0,1.0)}!2,
			{ExpRand(0.005,0.05)}!2
		);
		sum = sum + temp;
	};
	sum = sum * 0.5;
	Out.ar(0,sum);

}).add;
)

Synth.new(\iter, [\freq, 400]);
Synth.new(\iter, [\freq, 500]);
Synth.new(\iter, [\freq, 60.midicps]);  //Scarface
Synth.new(\iter, [\freq, 72.midicps]);  // Scarface
Server.default.record;   ///Record
Server.default.stopRecording;    ///Stop

([60, 62  ].do{
	arg midinote;
	Synth.new(\iter,[\freq, midinote.midicps]);
})  //play chords

Server.default.record;   ///Record
Server.default.stopRecording;    ///Stop

///Synth 3
(
SynthDef.new(\iter2, {
	arg freq = 200, dev =1.02;
	var temp, sum;
	sum = 0;
	20.do{
		arg count;
		temp = SinOsc.ar(
			freq *
			(count + 1) *
			LFNoise1.kr({Rand(0.5,0.2)}!2).range(dev.reciprocal,dev)
		);
		temp = temp * LFNoise1.kr({Rand(0,5,8)}!2).exprange(0.01,1);
				sum = sum + temp;
	};
	sum = sum * 0.05;
	Out.ar(0,sum);
}).add;)

x = Synth.new(\iter2);
x.free;


Server.default.record;   ///Record
Server.default.stopRecording;    ///Stop

///Synth 4


(SynthDef.new(\pulse,{
	arg ampHz = 4, fund = 48, maxPartial = 4, width = 0.5;
	var amp1, amp2, freq1, freq2, sig1, sig2;
	amp1 = LFPulse.kr(ampHz,0,0.12) * 0.75;
	amp2 = LFPulse.kr(ampHz,0.5,0.12) * 0.75;
	freq1 = LFNoise0.kr(4).exprange(fund, fund * maxPartial).round(fund);
	freq2 = LFNoise0.kr(4).exprange(fund, fund * maxPartial).round(fund);
	freq1 = freq1 * LFPulse.kr(8, add:1);
	freq2 = freq2 * LFPulse.kr(6, add:1);
	sig1 = Pulse.ar(freq1, width, amp1);
	sig2 = Pulse.ar(freq2, width, amp2);
	//sig1 = FreeVerb.ar(sig1, 0.7, 0.8, 0.25); //turtorial I watched added these for reverb but sounds fine without. Maybe better.
	//sig2 = FreeVerb.ar(sig2, 0.7, 0.8, 0.25); // See above comment.
	Out.ar(0,sig1);
	Out.ar(1,sig2);
}).add;)

x = Synth.new(\pulse);
x.set(\width, 0.35 ); // change tens position

Server.default.record;   ///Record
Server.default.stopRecording;    ///Stop

x.set(\fund, 80);
x.set(maxPartial,20);
x.set(\ampHz, 1);

x.free;

///Synth 5


x = {PinkNoise.ar * 0.33}.play;

x.free;

///Synth 6

x = Synth.new(\multi);
x.free;

Server.default.record;   ///Record
Server.default.stopRecording;    ///Stop

///Synth 7

p = Platform.resourceDir +/+ "sounds/a11wlk01.wav";
p = "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181023_142245.aiff"
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

///Synth 8

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

Server.default.record;   ///Record
Server.default.stopRecording;    ///Stop

///Synth 9

(
SynthDef(\feedbackDelay_Interal, {
	arg micIn = 0;
	var sig, inSig, fbSig;

	inSig = SoundIn.ar(micIn);

	fbSig = LocalIn.ar(1);

	sig = Mix([inSig, fbSig]);

	Out.ar(0, sig);

	sig = DelayC.ar(sig, 2, 0.5);

	LocalOut.ar(sig * 0.7);

}).add;
)

Synth(\feedbackDelay_Interal)

Server.default.record;   ///Record
Server.default.stopRecording;    ///Stop

///Synth 10  NOT IN USE

({
	var sig, note, freq;

	note = MouseX.kr(10, 127, warp: 0);
	note = note.floor.poll;
	freq = note.midicps;

	SinOsc.ar(freq, mul: 0.7);

}.play;
)


///Synth 11

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

Server.default.record;   ///Record
Server.default.stopRecording;    ///Stop

//////Buffers

//Store
~b0 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181023_130333.aiff");
~b1 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181023_135034.aiff");
~b2 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181023_135416.aiff");
~b3 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181023_135809.aiff");
~b4 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181023_141122.aiff");
~b5 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181023_141314.aiff");
~b6 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181023_141817.aiff");
~b7 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181023_142245.aiff");
~b8 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181023_151558.aiff");
~b9 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181023_151936.aiff");
~b10 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181023_153033.aiff");
~b11 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181023_155421.aiff");
~b12 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181023_161627.aiff");
~b13 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181023_162710.aiff");
~b14 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181023_164021.aiff");
~b15 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181023_164925.aiff");
~b16 = Buffer.read(s, );
~b17 = Buffer.read(s, );
~b18 = Buffer.read(s, );
~b19 = Buffer.read(s, );
~b20 = Buffer.read(s, );


//Play

~b0.play;///Pink Noise   simulate channel change (tv)
~b1.play;///Freq 400
~b2.play;//Freq 300
~b3.play;// Freq 100
~b4.play;//Freq 200
~b5.play;//Freq 500
~b6.play;//iter2              psychotic episode / trip out
~b7.play;//reverbBlips    leaky sink           slower
~b8.play;//pulse             music sequence
~b9.play;//Soft Pink Noise  simulate channel change  (tv)
~b10.play;//splayedSine      psychotic episode
~b11.play;// reverbBlips2          leaky sink 2
~b12.play;//reverbBlips3           leaky sink 3 warp out
~b13.play;//internalFeedbackDelay   characterChatter
~b14.play;//sketch2                 wine glasses / before sink music
~b15.play;//LFNoise0                Phone or video game
~b16.play;
~b17.play;
~b18.play;
~b19.play;
~b20.play;

~b1.zero;  ///Delete Buffer

~b1.read("C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181023_135034.aiff"); ///Replace Buffer