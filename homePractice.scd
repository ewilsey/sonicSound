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





