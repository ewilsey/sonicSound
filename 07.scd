//SynthDefs & Synths
//shortcut method
({}.play)

//SynthDef
/*
A SynthDef is a template for creating a synth node (object).
These are used by SCServer.
A Synth node is what SCServer uses to actually make sound.

We want to start explicitly defining Synth Definitions and launching Synth Nodes from those definitions.
This allow us;
- ability to pass references of nodes to other nodes
-Control the initialization and removal of individual noeds
-more easily control arguments in running nodes
*/

/////////////
//To define a SynthDef, use SynthDef()
(
SynthDef(\testSynth, {
		var sig;
		sig = SinOsc.ar(200);
		Out.ar(0,sig!2);
	}).add
)

// to play synth def (must define and summon in multiple key strokes)
Synth(\testSynth)


(
SynthDef(\whatever, {
arg freq = 200, mul = 0.7;
	var sig;
	sig = SinOsc.ar(freq, mul: mul);
	Out.ar(0,sig!2); // must specify an Out Ugen!
}).add;
)

Synth(\whatever)
Synth(\whatever, args:[\freq, 400, \mul, 0.5]);

//alter a running synth node
a = Synth(\whatever)
a.set(\freq, 400)
a.set(\mul, 0.1)
a.set(\freq,1000, \mul, 0.05)
a.dump

// to get argument values
a.get(\freq,{arg value; ("freq is now:" + value + "Hz").postln;});

a.free

//to see where recordings are placed, execute the following
thisProcess.platform.recordingsDir

//to record
s.record


//get source nexus or Dante Via
s.stopRecording