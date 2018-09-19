/*
Additive and Subtractive Synthesis
*/

(
{
	arg basefreq=200;
	var sig1, sig2, sig3, sig4, outSig;

	sig1=SinOsc.ar(baseFreq, mul:0.5);
	sig2=SinOsc.ar(baseFreq * 2, mul:0.5);
	sig3=SinOsc.ar(baseFreq * 3, mul:0.5);
	sig4=SinOsc.ar(baseFreq * 4, mul:0.5);

	outSig = Mix([sig1, sig2, sig3, sig4]);

	Out.ar( 0, outSig );
}.play;)

//
(
{

	arg bFreq=200;
	var n =10
	var wave = Mix.fill(10,{|i|
		var harmonicnumber= 2 +1; //odd harmonics only
		SinOsc.ar(bFreq*harmonicnumber)/harmonicnumber

})*0.25;
	Pan2.ar(wave,0.0); //stero, panned center
}.scope;

)