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


