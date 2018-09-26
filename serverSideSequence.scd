({
	var sig;
	sig=SinOsc.ar(0.1).linlin(-1,1,0,0.1);
	Out.ar(5,sig);
}.play)


({
	var sig;
	sig=SinOsc.ar(0.1).range(0,10);
	Out.ar(5,sig);
}.play)



({
	var sig;
	sig=SinOsc.ar(0.2, mul: 10);
	sig=sig.clip(1,2);
	Out.ar(5,sig);
}.play)
