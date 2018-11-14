//initialie midi (Musical Instrument Digital Interface

MIDIClient.init;

//Connect midi devices to SC

MIDIIn.connectAll


// match any noteOn message
(
MIDIdef.noteOn(\noteOnTest, {
	arg ...args;
	args.postln
},
(0 .. 127)
); // match any noteOn
)

//specific midi val function

(
MIDIdef.noteOn(\noteOn_48,{
	arg ... args;
	("Velocity is:" + arg[0]).postln;
},
48
); // match any noteOn
)

// CC function def

(
MIDIdef.cc(\midiCC_test,{
	arg ... args;
	"cc".post;
	args.postln;
},
(0 .. 127)
); //match cc 1-10
)


MIDIdef.cc(\test1, {arg ...args; args.postln}, 1); // match cc 1
MIDIdef.cc(\test2, {arg ...args; args.postln}, 1, 1); // match cc1, chan 1
MIDIdef.cc(\test3, {arg ...args; args.postln}, (1..10)); // match cc 1-10
MIDIdef.noteOn(\test4, {arg ...args; args.postln}); // match any noteOn

MIDIIn.doNoteOnAction(1, 1, 64, 64); // spoof a note on
MIDIIn.doControlAction(1, 1, 1, 64); // spoof a cc
MIDIIn.doControlAction(1, 1, 9, 64);
MIDIIn.doControlAction(1, 10, 1, 64);

MIDIdef(\test1).free; // free one def
MIDIdef.freeAll;      // free all registered MIDIdefs

/////////////// might need to replace with ICN
(
SynthDef(\der, {
	arg freq = 100, modRate = 0;
	var sig;
	sig = SinOsc.ar(freq, mul: 1 - SinOsc.ar(modRate).linlin (-1,1,0,1));
	Out.ar(0, sig!2);
}).add
)

a = Synth(\der)



a.set(\modRate, 2)
(

~bank = [];

MIDIdef(\noteOn, {
	arg ... args;  // all possible args
	var note, val;
	note = args[1];
	~bank[note] = Synth(\der, [\freq, note. midicps]);
}
(0 ... 127) // set to accept all note numbers  ( ... specifies all values between the range)
)
)