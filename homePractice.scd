a = {SinOsc.ar(200)* 0.25}; // freq, mul

b = a.play;

b.free;


(
c = {
	arg freq = 100, amp =1;
	var sig;
	sig = SinOsc.ar(freq) * amp;
}.play;
)

c.set(\freq, 330);
c.set(\amp, 0.125)
c.set(\freq, 660, \amp, 1);
c.set(\amp, 0.250, \freq, 550);
c.free;

(d= {
	var freq, sig;
	freq = LFNoise0.kr(8, 400, 600);
	sig = SinOsc.ar(freq);
}.play;)
d.free;

(e= {
	arg lfN = 8;
	var freq, amp, sig;
	freq = LFNoise0.kr(lfN, 400, 600);
	amp = LFNoise1.kr(12).exprange(0.02,1);
	sig = SinOsc.ar(freq);
}.play;)
e.set(\lfN, 64);
e.set(\lfN, exprand(4,64));
e.free;

/////////////////
//s.boot;
//s.quit;
/////////////////

(SynthDef.new(\sine,{
	arg lfN = 8;
	var freq, amp, sig;
	freq = LFNoise0.kr(lfN, 400, 600);
	amp = LFNoise1.kr(12).exprange(0.02,1);
	sig = SinOsc.ar(freq)* amp;
	Out.ar(0,sig);

}).add;)

x = Synth.new(\sine);
x.free;

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
x.set(\width, 0.65 ); // change tens position
x.set(\fund, 80);
x.set(maxPartial,20);
x.set(\ampHz, 1);

x.free;

x = Synth.new(\pulse, [\ampHz, 3.3, \fund, 48, \maxPartial, 4, \width, 0.35]);

x.free;

/////////////////////////////////////

x = {PinkNoise.ar * 0.33}.play;

x.free;


({
	var sig, env;
	env = Line.kr(1,0,1, doneAction: 2);
	sig = Pulse.ar(ExpRand(30,500)) * env;
}.play;)

({
	var sig, env;
	env = XLine.kr(1,0.01,1, doneAction: 2);
	sig = Pulse.ar(ExpRand(30,500)) * env;
}.play;)

({
	var sig, freq, env;
	env = XLine.kr(1,0.01,5, doneAction: 2);
	        //done action ^ per this longer duration.
	freq = XLine.kr(880, 110, 1);
	sig = Pulse.ar(freq) * env;
}.play;)

({
	var sig, freq, env;
	env = XLine.kr(1,0.01,5);
	freq = XLine.kr(880, 110,10, doneAction: 2); // done action on longer duration
	sig = Pulse.ar(freq) * env;
}.play;)

Env.new.plot;

s.quit;

(x = {
	arg t_gate = 0;
	var sig, env;
	env = EnvGen.kr(Env.new(
		[0.01, 1, 0.2, 0.01],
		[0.5,1,2],
		[3,-3, 0]),t_gate); //set trigger rate
	sig = Pulse.ar(LFPulse.kr(8).range(600,900)) * env;
}.play;)

x.set(\t_gate, 1);

(x = {
	arg gate = 0;
	var sig, env, freq;
	freq = EnvGen.kr(Env.adsr(1), gate, 200, 0.1);
	env = EnvGen.kr(Env.adsr, gate);
	sig = VarSaw.ar(SinOsc.kr(16).range(500,1000)) * env;
}.play;)


x.set(\gate, 0.0);
x.free;
///////////////////////////////////////multichannelExpansion

x = {SinOsc.ar([300,500])}.play; // two sine channels

(
SynthDef.new(\multi,{
	var sig, amp, env;
	env = EnvGen.kr(
		Env.new([0,1,0],[10,10],[1,-1]),doneAction:2);
	amp = SinOsc.kr({ExpRand( 0.2, 12)}!8).range(0,1);
	sig = SinOsc.ar({ExpRand(50,1200)}!8);
	sig = sig * amp * env;
	sig = Splay.ar(sig) * 0.5;
	Out.ar(0,sig);
}).add;
)

x = Synth.new(\multi);
x.free;

rrand(10,2000)!5; // 5 instances of the same number chosen at random
{rrand(10,2000)}!5; //5 random numbers

//////////////////////////////////////////////////iteration

(5).do{"hello".postln};

(
SynthDef.new(\iter,{
	arg freq = 40;
	var temp, sum, env;
	sum = 0;
	env = EnvGen.kr(
		Env.perc(0.01,5,1,-2),doneAction:2
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
Synth.new(\iter, [\freq, 300]);
Synth.new(\iter, [\freq, 60.midicps]);  //Scarface
Synth.new(\iter, [\freq, 75.midicps]);  // Scarface

([60, 67  ].do{
	arg midinote;
	Synth.new(\iter,[\freq, midinote.midicps]);
})  //play chords

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
///////////////////////////////////Server Arch
Nodes, Buses, Order of Exection
Nodes -> {Synth, Group}

s.options.numAudioBusChannels;
s.options.numOutputBusChannels;
s.options.numInputBusChannels;

(
SynthDef.new(\blip,{
	arg out;
	var freq, trig, sig;
	freq = LFNoise0.kr(3).exprange(300,1200).round(300);
	sig = SinOsc.ar(freq) * 0.25;
	trig = Dust.kr(2);
	sig = sig * EnvGen.kr(Env.perc(0.01, 0.2), trig);
	sig = Pan2.ar(sig, LFNoise1.kr(10));
	Out.ar(out, sig);
}).add;
)

(
SynthDef.new(\reverb,{
	arg in, out  = 0;
	var sig;
	sig = In.ar(in,1);
	sig = FreeVerb.ar(sig, 0.5, 0.8, 0.2)!2;
	Out.ar(out, sig);
}).add
)

y = Synth.new(\reverb, [\in, 1]);
x = Synth.new(\blip, [\out, 1]);
y = Synth.new(\reverb, [\in, ~reverbBus]);
x = Synth.new(\blip, [\out, ~reverbBus]);

~reverbBus = Bus.audio(s,1);
~reverbBus.index;


//////////////////////////////////Buffer

~b0.play;

s.boot;
// allocate an array of Buffers and fill them with different harmonics
(
b = Buffer.allocConsecutive(8, s, 4096, 1, { |buf, i|
    buf.sine1Msg((1..((i+1)*6)).reciprocal) // completion Messages
});

a = { VOsc.ar(SinOsc.kr(0.5, 0).range(b.first.bufnum + 0.1, b.last.bufnum - 0.1),
    [440, 441], 0, 0.2) }.play;
)
a.free;

// iterate over the array and free it
b.do(_.free);


//FRAMES
~b0.numFrames;

//Channels
~b0.numChannels;
numSamples = numFrames * numChannels

//Duration
~b2.duration;

//Buffer Numbwers (bufnums)
~b0.bufnum;
~b1.bufnum;
~b2.bufnum;
~b3.bufnum;

//Buffer Sample Rate
~b0.sampleRate;
s.sampleRate;

// Summary
~b0.query;

//available buffers on server

s.options.numBuffers;


(SythDef.new(\playbuf_test,{
	arg amp =1, out = 0, buf;
	var sig;
	sig = PlayBuf.ar(2,buf);
	sig = sig * amp;
	Out.ar(out, sig);
}).add;)

Synth.new(\playbuf_test,[\buf, ~b0.bufnum]);
                 //changing this ^ selects stored buffer to play.


//////////////////////////midi
  