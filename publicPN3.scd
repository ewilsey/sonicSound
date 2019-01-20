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
d.add(\drum7 -> PathName("C:/Users/ericw/OneDrive/Documents/SuperCollider/SuperCollider/Recordings/Drum7").entries.collect({
	arg sf;
	Buffer.read(s, sf.fullPath);
});
);
)
//test
d[\drum].choose.play;
d[\drum2].choose.play;
d[\drum7].choose.play;
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

Server.default.record;   ///Record
Server.default.stopRecording;    ///Stop



(Pdef(
	\rhythm4,
	Pbind(
		\instrument, \bufplay,
		\dur, Pseq([1/10],inf),
		\buf, Pxrand(d[\drum4],inf),
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
		\dur, Pseq([1/10],inf),
		\buf, Pxrand(d[\drum6],inf),
		\rate, 1,
		\amp, 0.15,
		\stretch, 1.875,
	);
).play(quant:1.875);
)

(Pdef(
	\rhythm2,
	Pbind(
		\instrument, \bufplay,
		\dur, Pseq([1/10],inf),
		\buf, Pxrand(d[\drum5],inf),
		\rate, 1,
		\amp, 0.25,
		\stretch, 1.875,
	);
).play(quant:1.875);
)

(Pdef(
	\rhythm2,
	Pbind(
		\instrument, \bufplay,
		\dur, Pseq([1/10],inf),
		\buf, Pxrand(d[\drum5],inf),
		\rate, 1,
		\amp, 0.25,
		\stretch, 1.875,
	);
).stop(quant:1.875);
)

Server.default.record;   ///Record
Server.default.stopRecording;    ///Stop

Buffer.freeAll;