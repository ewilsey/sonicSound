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
	\freq, Pexprand(50, 4000, inf).trace,
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

// SOFT -> harmonics in place of freq -> Toaster, Dream Seq, Credits.
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

//PDEF -> Adjustable while playing version

(
Pdef(
    \sinepat,
	Pbind(
		\type, \note,
	    \instrument, \sine,
	    \dur, Pwhite(0.05, 0.5, inf),
        \midinote, Pseq([29], inf).trace,
	    \harmonic, Pexprand(1, 80, inf).round,
	    \atk, Pwhite(2.0, 3.0, inf),
	    \rel, Pwhite(5.0, 10.0, inf),
	    \amp, Pkey(\harmonic).reciprocal * 0.3,
	    \pan, Pwhite(-0.8, 0.8, inf),
	);
).play;
)

//// Buffers and manipulating them

//////Buffers

//Store
~b0 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181127_113126.aiff");
~b1 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181127_113158.aiff");
~b2 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181127_113233.aiff");
~b3 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181127_113255.aiff");
~b4 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181127_113321.aiff");
~b5 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181127_113350.aiff");
~b6 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181127_113420.aiff");
~b7 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181127_113451.aiff");
~b8 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181127_113544.aiff");
~b9 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181127_113551.aiff");
~b10 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181127_113604.aiff");
~b11 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181127_113613.aiff");
~b12 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181127_113622.aiff");
~b13 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181127_113636.aiff");
~b14 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181127_113648.aiff");
~b15 = Buffer.read(s, "C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/SC_181127_113656.aiff");
~b16 = Buffer.read(s, );
~b17 = Buffer.read(s, );
~b18 = Buffer.read(s, );
~b19 = Buffer.read(s, );
~b20 = Buffer.read(s, );


//Play

~b0.play;// Car door
~b1.play;// More knocks, long.
~b2.play;// Too much feedback.
~b3.play;// Louder Frog
~b4.play;// Too much feedback.
~b5.play;// Harr
~b6.play;// Knocking w/ whistle
~b7.play;// Random knocks
~b8.play;// Hrehh
~b9.play;// Ruuhh
~b10.play;// Rhehh
~b11.play;// Chh
~b12.play;// Haa
~b13.play;// Ughngh
~b14.play;// Ha ah ah
~b15.play;// Ha ha ha
~b16.play;//
~b17.play;//
~b18.play;//
~b19.play;//
~b20.play;//

//Patterns of Buffers

(
d = Dictionary.new;
d.add(\l -> PathName("C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/Random Noises").entries.collect({
	arg sf;
	Buffer.read(s, sf.fullPath);
});
);
d.add(\drum -> PathName("C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/Drum").entries.collect({
	arg sf;
	Buffer.read(s, sf.fullPath);
});
);
)
//test
d[\drum].choose.play;

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
	sig = sig * amp;
	Out.ar(0, sig);
}).add;
)
 // test synthdef
Synth.new(\bufplay, [\buf, d[\l].choose.bufnum]);


// Freaking madness!!! Prand more rhythmic than Pxrand here.
(Pdef(
	\rhythm,
	Pbind(
		\instrument, \bufplay,
		\dur, Pseq([1/16],inf),
		\buf, Prand(d[\l],inf),
		\rate, 1,
		\amp, 0.5,
		\stretch, 1.875,
	);
).play;
)


//keyboards
(
Pdef(
    \sinepat,
	Pbind(
	    \instrument, \sine,
		\dur, Pseq([1/16], inf),
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

//Drums (not quite there)

(Pdef(
	\rhythm,
	Pbind(
		\instrument, \bufplay,
		\dur, Pseq([1/16],inf),
		\buf, Prand(d[\drum],inf),
		\rate, Pexprand(3,4.25,inf),
		\amp, Pseq([0.8, Pexprand(0.005,0.3,7)],inf),
		\stretch, 1.875,
	);
).play(quant:1.875);
)

Buffer.freeAll;