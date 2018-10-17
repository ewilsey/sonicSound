(

{

	var in = Decay.ar(Pulse.ar(200,SinOsc.kr(0.2).range (0.01, 0.99)  *(Saw.ar(XLine.kr(100,100,5)))));

	var sound, feedback;



	feedback = LocalIn.ar(2);	//one channel of feedback



	sound = in + feedback;


  // reverse channels to give ping pong effect, apply decay factor
    LocalOut.ar(feedback.reverse * 0.8);



	sound;



}.play;

)