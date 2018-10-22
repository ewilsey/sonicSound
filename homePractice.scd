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
	env = XLine.kr(1,0.01,10, doneAction: 2); //done action on longer duration.
	freq = XLine.kr(880, 110, 5);
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

x.set(\gate, 0);
x.free;
///////////////////////////////////////

x = {SinOsc.ar([300,500])}.play; // two sine channels multichannel expansion

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

//////////////////////////////////////////////////
