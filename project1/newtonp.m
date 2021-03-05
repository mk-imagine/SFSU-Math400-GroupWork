%%  Math 400 Spring 2021 Project 1
%%  Section 3 Part A
%%  Adapted from the class Newton's method Matlab code 


function c = newtonp(x0, delta)

%% 	
%% newton.m
%% 
%% Implements Newton's method
%%
%% Input: 	x0	initial guess for the root of f
%% 		delta	the tolerance/accuracy we desire
%%                      (Code runs until |f(c)| <= delta.)
%% 
%% Output:	c 	the approxmiation to the root of f
%% 
%% Syntax:	newton(x0, delta)
%%
format long e

c = x0;    
fc = f(x0);                   
fprintf('x0:  c=%d, fc=%d, error=%d\n',c,fc,abs(2-c))
if abs(fc) <= delta             %% check to see if initial guess satisfies
  return;                       %% convergence criterion.
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                       %%
%% main routine                                                          %%
%%                                                                       %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p_x = linspace (-2, 2, 100); 
p_y = f(p_x);
fig1 = figure('position',[ 0 0 700 1000 ]);
movegui(fig1, 'center');
counter=0;

while abs(fc) > delta,
    fpc = fprime(c);        

    if fpc==0,                    %% if fprime is 0, abort.
        error('fprime is 0')        %% the error function prints message and exits
    end;

    c = c - fc/fpc;               %% Newton step
    fc = f(c);
  
    %%plot the tangent
    counter = counter + 1;
    %p_x = linspace (-2, 2, 100); 
    %p_y = f(p_x); 
    t_x = linspace (x0-2, x0+2, 10);
    %t_y = fpc*t_x + (fc-fpc*x0);
    %figure();
    subplot(4,2,counter)
    plot(t_x, t_y, 'r-', p_x, p_y, 'b-');
    title("Plot of f(x) with tangent at x" + (counter-1) + ".")
    grid('on');
    xlabel('x'); 
    ylabel('f(x)');
    disp('...press enter to continue')
    pause on; pause;


    fprintf('x%d:  c=%d, fc=%d, error=%d\n',counter-1,c,fc,abs(2-c))

  
end;


%%
%% put subroutines here
%%
%%
function fx = f(x)
	fx = tanh(x); %% Enter your function here.
	return;
function fprimex = fprime(x)
	fprimex = (sech(x))^2; %% Enter the derivative of your function here.
	return;


%%After observing the plot of x0 = 1.08, the tangent bounce around in
%%between each iterations but eventually bring out the solution at x=0
%%which is tangent line. On the other hand, the plot of x0 = 1.09, we found
%%that even though the tangent line may came close to it, at last it moved
%%further away from the line (solution) which Newton method fails. 



