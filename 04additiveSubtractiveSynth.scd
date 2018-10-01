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

//Square wave: Add up n harmonics with amplitude falling off as 1/ harmonicnumber, sign alternates etween +1 and -1
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

/*
Subtractive Synthesis
*/


//various types of input noise
({
	var sig;

	//sig = WhiteNoise.ar(0.707);
	//sig = PinkNoise.ar(0.707);  //testing and noise based creations per more organic sound
	//sig = BrownNoise.ar(0.707); // even more ocean-y
	//sig = GrayNoise.ar(0.707);
	//sig = ClipNoise.ar(0.707);
}.play;)



({
	var sig;
	sig= PinkNoise.ar(MouseY.kr(0, 0.707));
	sig = LPF.ar( sig, freq: MouseX.kr( 100, 20000));
}.play;)  //wind and or water


//resonant lowpass filter
//notice how low 'q' creates a more distinguished resonant freq!
({
	var sig;
	sig= PinkNoise.ar( 0.707);
	sig = RLPF.ar( sig, freq: MouseX.kr( 100, 18000).poll(label:\freq), rq:
	MouseY.kr(0.001,0.99).poll(label: \rq) );
}.play;)


({
	var sig;

	sig= PinkNoise.ar( 0.707 );
	sig = Resonz.ar( sig, freq: MouseX.kr( 100, 10000).poll(label:\freq), bwr:
		MouseY.kr(0.001,10).poll(label: \bwr) );
}.play;)



