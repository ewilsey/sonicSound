//hello World w/ Input Arguments
"Hello World!".postln;

// a sine wave w/ freq-> 200Hz
{ SinOsc.ar( freq: 200, mul: 1.0 ) }.play;

// Using a control reate Ugen applied to the freq parameter of the SinOsc
{ SinOsc.ar( freq: 80 + (400 * MouseX.kr), mul: 0.707 ) }.play;

 /* First day basics, more on class repository */