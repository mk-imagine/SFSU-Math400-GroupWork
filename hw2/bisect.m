function c = bisect(a, b, delta)
%%
%% bisect.m
%% 
%% Implements the bisection method
%%
%% Input: 	a 	the left endpoint of the interval
%% 		b 	the right endpoint of the interval
%% 		delta	the tolerance/accuracy we desire
%%                      (Routine will iterate until interval
%%                      has width at most 2*delta so that
%%                      midpoint is within delta of root.)
%%
%% Output:	c 	the approxmiation to the root of f
%% 
%% Syntax:	bisect(a, b, delta)
%%

fa = f(a); 			%% compute initial values of f(a) and f(b)
fb = f(b); 
counter = 1;

if  sign(fa) == sign(fb)	%% sanity check: f(a) and f(b) must have different
				%% signs
				%% 
				%% the error function prints an error message and
				%% exits
	error('f must have different signs at the endpoints a and b.  Aborting.')
end
fprintf('initial interval:\n\ta=%d, b=%d, fa=%d, fb=%d\n',a,b,fa,fb)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                       %%
%% main routine                                                          %%
%%                                                                       %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

while ( abs(b - a) > 2*delta )	%% While the size of the interval is
				%% larger than the tolerance

	c = (b + a)/2;		%% Set c to be the midpoint of the interval

	fc = f(c);		%% Calculate the value of f at c

	if sign(fc) ~= sign(fb)	%% If f(c) and f(b) are of different sign, then
				%% f must have a zero between c and b (by the 
				%% Intermediate Value Theorem).
		a = c; 	fa = fc;
	else 			%% This is the case where f(a) and f(c) are of 
				%% different sign.
			        %%	
		b = c;	fb = fc;
	end
				%% Repeat the algorithm on the new interval
        fprintf('   a=%d, b=%d, fa=%d, fb=%d\n',a,b,fa,fb)
        counter = counter + 1;
end
fprintf('iterations = %d',counter)
%%
%% put subroutines here
%%
%%
function fx = f(x)
%	%% Enter your function here.
       fx = x+10-exp(x); 
	return;