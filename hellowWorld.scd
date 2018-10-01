 /* First day basics, more on class repository. This is a block comment */

//hello World w/ Input Arguments
"Hello World!".postln;

// a sine wave w/ freq-> 200Hz
{ SinOsc.ar( freq: 200, mul: 1.0 ) }.play;

// simple amplitude modulation
{ SinOsc.ar( freq: 200 ) * SinOsc.kr(0.5).poll }.play;

// 'mul' is a multiplier to the output signal.

// almost all ugens (unit generators) and processing units have a mul argument optional

// Poll mouse X UGen to the post window
{ MouseX.kr.poll }.play;

// use mouseX UGen to drive the amplitude of a sine wave
{ SinOsc.ar( freq: 200 ) * MouseX.kr.poll }.play;

// Using a control rate Ugen applied to the freq parameter of the SinOsc
{ SinOsc.ar( freq: 80 + (400 * MouseX.kr), mul: 0.707 ) }.play;

// Use MouseX UGen to drive the frequency of a sine wave
{ SinOsc.ar(freq: MouseX.kr(20, 3000) ) }.play;
// Use Mouse X/Y to create a pseudo-theramin
{ SinOsc.ar( freq: MouseX.kr( 20, 2000 ), mul: MouseY.kr(0,1) ) }.play;


// Use amplitude modulation to create complex wave forms
{ SinOsc.ar( freq: 200 ) * SinOsc.kr(20).poll }.play;


// mouse driven complex amplitude modulation
{ SinOsc.ar( freq: MouseX.kr( 20, 2000 ) ) * SinOsc.ar(MouseY.kr(0, 100).poll ) }.play;