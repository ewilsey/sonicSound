//Work section for Public Presentation Dec 3

//Toaster oven scene, potato position change, zoom in to eyes turning from ivory to red as he is baked alive.
(
{
    var in, chain;
    in = WhiteNoise.ar(0.8);
    chain = FFT(LocalBuf(2048), in);
    chain = PV_RandComb(chain, 0.95, Impulse.kr(0.4));
    IFFT(chain)
}.play;
)

// Pre Toatster scene, water for sink as Potato is washed. (Potato's perspective)
(
SynthDef("Water", { arg out=0;
    Out.ar(out,
        BrownNoise.ar(0.05)
    )
}).play;
)

//scale up. Garden as Potato Plant is growing and producing Potatoes. Scene immediately before Store. ( Record only scale portion)
{ Blip.ar(100,Line.kr(1,100,40),0.2) }.play;
////  tone^^^               ^^speed



/// Possible alarm. Could also be phone alarm.
(
{ var trig;
    trig = Impulse.kr(MouseX.kr(0.5, 20, 1)); //bottom left slow alarm
    SinOsc.ar(Sweep.kr(trig, 700) + 500, 0, 0.2)
}.play;
)

//sweeper used to index buffer , allows sweeping of buffers. may discover unique sound profiles.
b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav");

(
{ var trig;
    trig = Impulse.kr(MouseX.kr(0.5, 10, 1));
    BufRd.ar(1, b, Sweep.ar(trig, BufSampleRate.ir(0)))
}.play;
)

//Play Above Backwards...
(
{ var trig, pos, rate;
    trig = Impulse.kr(MouseX.kr(0.5, 10, 1));
    rate = BufSampleRate.ir(0);
    pos = Sweep.ar(trig, rate.neg) + (BufFrames.ir(0) * LFNoise0.kr(0.2));
    BufRd.ar(1, b, pos)
}.play;
)

//higher faster, wierder
(
{ var trig, rate;
    trig = Impulse.kr(MouseX.kr(0.5, 10, 1));
    rate = Sweep.kr(trig, 2) + 0.5;
    BufRd.ar(1, b, Sweep.ar(trig, BufSampleRate.ir(0) * rate))
}.play;
)

b.free

//