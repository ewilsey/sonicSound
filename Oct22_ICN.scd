(
a =0;
t = Task({
	inf.do({
		a=a+1;
		a.postln;
		1.0.wait; // must have w/ inf.do or server will break
	});
}).play;
)

Routine
Task
