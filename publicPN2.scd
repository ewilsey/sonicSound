(SynthDef.new(\sine, {
	arg freq= 440, atk= 0.05, rel=0.45, amp=1, pan=0;
	var sig, env;
	sig = SinOsc.ar(freq);
	env = EnvGen.kr(Env.new([0,1,0], [atk,rel], [1,-1]), doneAction:2);
	sig = Pan2.ar(sig,pan,amp);
	sig = sig * env;
	Out.ar(0,sig);
}).add;
)


//test synth
Synth.new(\sine);

//simplest Pbind -> dur of 1 = leaky sink; 0.4 = cardoor alarm.
(
p = Pbind(
	\type, \note,
	\instrument, \sine,
	\dur, 0.4,
).play;
)

p.stop;

Server.default.record;   ///Record
Server.default.stopRecording;    ///Stop

// Pseq -> needs adjusting. Some sort of alarm.
(
p = Pbind(
	\type, \note,
	\instrument, \sine,
	\dur, Pseq([0.6, 0.15, 0.15], inf).trace,
	\midinote, Pseq([60,65,67,73], inf).trace,
	//\freq, Pseq([300, 250, 350], inf).trace,
	//\freq, Pexprand(50, 4000, inf).trace,
).play;
)

p.stop;

// Pexprand and Pwhite -> random generated whistling chimes/ wine glasses
(
p = Pbind(
	\type, \note,
	\instrument, \sine,
	\dur, Pwhite(0.05, 0.5, inf).trace,
	//\midinote, Pseq([60,65,67,73], inf).trace,
	//\freq, Pseq([300, 250, 350], inf).trace,
	\freq, Pexprand(50, 400, inf).trace,
).play;
)

p.stop;

// LOUD adjusts everything -> Dream Sequence/ Toaster/Credits.
(
p = Pbind(
	\type, \note,
	\instrument, \sine,
	\dur, Pwhite(0.05, 0.5, inf).trace,
	\freq, Pexprand(50, 4000, inf).round(55).trace,
	\atk, Pwhite(2.0, 3.0, inf),
	\rel, Pwhite(5.0, 10.0, inf),
	\amp, Pexprand(0.01, 0.2, inf),
	\pan, Pwhite(-0.8, 0.8, inf),
).play;
)

p.stop;

// Still LOUD -> harmonics in place of freq -> Toaster, Dream Seq, Credits.
(
p = Pbind(
	\type, \note,
	\instrument, \sine,
	\dur, Pwhite(0.05, 0.5, inf).trace,
	\midinote, 33,
	\harmonic, Pexprand(1, 80, inf).round.trace,
	\atk, Pwhite(2.0, 3.0, inf),
	\rel, Pwhite(5.0, 10.0, inf),
	\amp, Pkey(\harmonic).reciprocal * 0.3,
	\pan, Pwhite(-0.8, 0.8, inf),
).play;
)

p.stop;


//// Buffers and manipulating them

//////Buffers
//record

Server.default.record;   ///Record
Server.default.stopRecording;    ///Stop

//Patterns of Buffers

(
d = Dictionary.new;
d.add(\drum -> PathName("C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/Drum").entries.collect({
	arg sf;
	Buffer.read(s, sf.fullPath);
});
);
d.add(\drum2 -> PathName("C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/Drum2").entries.collect({
	arg sf;
	Buffer.read(s, sf.fullPath);
});
);
d.add(\drum3 -> PathName("C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/Drum3").entries.collect({
	arg sf;
	Buffer.read(s, sf.fullPath);
});
);
d.add(\drum4 -> PathName("C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/Drum4").entries.collect({
	arg sf;
	Buffer.read(s, sf.fullPath);
});
);
d.add(\drum5 -> PathName("C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/Drum5").entries.collect({
	arg sf;
	Buffer.read(s, sf.fullPath);
});
);
d.add(\drum6 -> PathName("C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/Drum6").entries.collect({
	arg sf;
	Buffer.read(s, sf.fullPath);
});
);
)
//test
d[\drum].choose.play;
d[\drum2].choose.play;
d[\drum3].choose.play;

(SynthDef.new(\sine, {
	arg freq= 440, atk= 0.05, rel=0.45, amp=1, pan=0;
	var sig, env;
	sig = SinOsc.ar(freq);
	env = EnvGen.kr(Env.new([0,1,0], [atk,rel], [1,-1]), doneAction:2);
	sig = Pan2.ar(sig,pan,amp);
	sig = sig * env;
	Out.ar(0,sig);
}).add;
)

(
SynthDef.new(\bufplay,{
	arg buf=0, rate=1, amp=1;
	var sig;
	sig = PlayBuf.ar(2, buf, BufRateScale.ir(buf) * rate, doneAction:2);
	sig = Mix(sig);
	sig = sig * amp;
	sig = Pan2.ar(sig, LFNoise2.kr(0.5));
	Out.ar(0, sig);
}).add;
)
 // test synthdef
Synth.new(\bufplay, [\buf, d[\drum].choose.bufnum]);



(Pdef(
	\rhythm3,
	Pbind(
		\instrument, \bufplay,
		\dur, Pseq([1/10],inf),
		\buf, Pxrand(d[\drum2],inf),
		\rate, 1,
		\amp, 0.05,
		\stretch, 1.875,
	);
).play(quant:1.875);
)

////////////////////////////////MUSIC!!!!!!///////////////////////////////


////////keyboards Opening Credits at 1/10 dur//////
(
Pdef(
    \sinepat,
	Pbind(
	    \instrument, \sine,
		\dur, Pseq([1/10], inf),
		\stretch, 1.875,
        \note, Pxrand([0,3,5,9,10,12], inf).trace,
	    \atk, 0.005,
	    \rel, Pexprand(0.01, 0.5, inf),
		\amp, Pexprand(0.05,0.5,inf),
	    \pan, Pwhite(-0.8, 0.8, inf),
		\gtranspose, -2,
	);
).play(quant:1.875);
)

///////Drums Opening Credits at 1/10 dur/////////////
Server.default.record;   ///Record
Server.default.stopRecording;    ///Stop

(Pdef(
	\rhythm,
	Pbind(
		\instrument, \bufplay,
		\dur, Pseq([1/10],inf),
		\buf, Pxrand(d[\drum],inf),
		\rate, Pexprand(3,4.25,inf),
		\amp, Pseq([0.8, Pexprand(0.005,0.3,7)],inf),
		\stretch, 1.875,
	);
).play(quant:1.875);
)


(Pdef(
	\rhythm2,
	Pbind(
		\instrument, \bufplay,
		\dur, Pseq([1/],inf),
		\buf, Pxrand(d[\drum2],inf),
		\rate, 1,
		\amp, 0.25,
		\stretch, 1.875,
	);
).play(quant:1.875);
)

(Pdef(
	\rhythmg,
	Pbind(
		\instrument, \bufplay,
		\dur, Pseq([1/5],inf),
		\buf, Pxrand(d[\drum5],inf),
		\rate, 1,
		\amp, 0.25,
		\stretch, 1.875,
	);
).play(quant:1.875);
)


(Pdef(
	\rhythm4,
	Pbind(
		\instrument, \bufplay,
		\dur, Pseq([1/5],inf),
		\buf, Pxrand(d[\drum6],inf),
		\rate, 1,
		\amp, 0.01,
		\stretch, 1.875,
	);
).play(quant:1.875);
)
////////////////////////////////TOASTER////////////////
//PDEF -> Adjustable while playing version

(
Pdef(
    \sinepat2,
	Pbind(
		\type, \note,
	    \instrument, \sine,
	    \dur, Pseq([1/5],inf),
        \midinote, Pseq([16], inf).trace,
	    \harmonic, Pexprand(1, 80, inf).round,
	    \atk, Pwhite(2.0, 3.0, inf),
	    \rel, Pwhite(5.0, 10.0, inf),
	    \amp, Pkey(\harmonic).reciprocal * 0.3,
	    \pan, Pwhite(-0.8, 0.8, inf),
	);
).play;
)
//////////// Big Bass Drum Beat END CREDITS at 1/8 dur////////
(Pdef(
	\rhythm2,
	Pbind(
		\instrument, \bufplay,
		\dur, Pseq([1/5],inf),
		\buf, Pxrand(d[\drum3],inf),
		\rate, 1,
		\amp, 0.25,
		\stretch, 1.875,
	);
).play(quant:1.875);
)

//Drums 2 END CREDITS at 1/8 dur

(Pdef(
	\rhythm,
	Pbind(
		\instrument, \bufplay,
		\dur, Pseq([1/8],inf),
		\buf, Pxrand(d[\drum3],inf),
		\rate, Pexprand(3,4.25,inf),
		\amp, Pseq([0.8, Pexprand(0.005,0.3,7)],inf),
		\stretch, 1.875,
	);
).play(quant:1.875);
)

/////GAME OVER MAN
Buffer.freeAll;