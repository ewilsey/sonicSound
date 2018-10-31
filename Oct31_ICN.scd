(
SynthDef(\yeah,{
	arg freq = 440, amp = 0.707, gate = 1, sustain = 1;
	var sig, env;

	env = Env.adsr(0.01 * sustain, 0.3, amp * 0.5, 0.5 * sustain);
	env= EnvGen.kr(env, gate, amp, doneAction:2);

	sig = SinOsc.ar(freq, mul: env);
	sig = sig * SinOsc.ar(3).linlin(-1,1,0,1);

	sig = Pan2.ar(sig, 0);
	Out.ar(0,sig);
}).add;
)

(
a = Pbind(
	\instrument, \yeah,
	\note, Pseq([0,0,7,7,9,9,7],1),
	\dur, Pseq([1,1,1,1,1,1,2],1),
	// \amp Pseq([1,1,0.5,0.5,0.25,0.25,1],1),
	\db, -6,
	\sustain, 2,
	\test, Pfunc({|ev| ~der = ev})

).play;
)


//////////////////////////////////////////////////
(
Pdef(\yeahPat,
	Pbind(
		\instrument, \yeah,
		\note, Pseq([0,0,7,7,9,9,7],1),
		\dur, Pseq([1,1,1,1,1,1,2],1),
		// \amp Pseq([1,1,0.5,0.5,0.25,0.25,1],1),
		\db, -6,
		\sustain, 2,
		\test, Pfunc({|ev| ~der = ev}),
		\modFreq, Prand([2, 60, 20, 120],inf)
	)
)
)

Pdef(\yeahPat).play;

// you can change in real time!!!!!
Pdef(\notePat, Pseq([9,11,0],inf);


/////////////////
Server.killAll;
////////////////

// Pull up help on server options

(
		// grab server options for local server
		//assign to var 'o'
		o = Server. default.options;

		//return an array of available devices
		ServerOptions.devices
		o.inDevice = ServerOptions.devices[0];
		o.inDevice = "Built-in Microph";
		o.outDevice = ServerOptions.devices[1];
	)
		s.reboot

		// specify the num of hardware channels
		o.numInputBusChannels= 4;
		o.numOutputBusChannels = 8;

		//increase the memory size SC utilizes
		0.memZize = 2 ** 21;

		s.reboot;

		(
		s.doWhenBooted({
			MIDIClient.init; MIDIIn. connectAll;
			s.plotTree;
			s.meter;
		});
	)

		// to utilize multiple files, you must explicitly load them in:
	//("REPLACE WITH FILE TO BE LOADED HERE").loadPaths;    //old
	("./nameOfSubDir/*").loadRelative;   //new