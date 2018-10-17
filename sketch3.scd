(

{

	var source = Impulse.ar(XLine.kr(800,100,5), 0.0,  0.5, 0);

	var sound, feedback;



	feedback = LocalIn.ar(1);	//one channel of feedback



	sound = source + feedback;



	LocalOut.ar(sound* MouseY.kr(0,0.9));  //feedback sound with some gain (<1 to stop feedback building up and overloading!).



	sound;



}.play

)