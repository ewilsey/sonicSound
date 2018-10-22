(
a =0;
t = Task({
	inf.do({
		a=a+1;
		a.postln;
		1.0.wait; // must have w/ inf.do or server will break
	});
}).play;
)

Routine
Task

(
a ={
	arg freq = 200;
	var carr, mod, sig;
	mod = SinOsc.kr(MouseX.kr(0.01, 1000).poll).linlin(-1,1, freq/2, freq*2);
	carr = SinOsc.ar(freq * mod ) * 0.707;
	Out.ar(0,carr);
}.play

)

(
{SinOsc.kr()}.play;
)

          