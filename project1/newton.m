%%  Math 400 Spring 2021 Project 1
%%  Section 3 Part A
%%  Adapted from the class Newton's method Matlab code
%%  Nyan Tun (primary coder), Adrian Lopez, Amber Hartigan, Alyssa Reyes,
%%  and Mark Kim


function c = newton(x0, delta)

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
if abs(fc) <= delta             %% check to see if initial guess satisfies
  return;                       %% convergence criterion.
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                       %%
%% main routine                                                          %%
%%                                                                       %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p_x = linspace (-4, 4, 100); % Create x vector for function plot
p_y = f(p_x);                % Calculate y vector for function plot
fig1 = figure('position',[ 0 0 700 1000 ]); % Size figure
movegui(fig1, 'center');                    % Position figure in center of screen
counter=0; % step counter for each evaluation

while abs(fc) > delta % Continue until evaluation satisfies convergence criterion
    fpc = fprime(c);        % Calculate derivative at current step

    if fpc==0                      % if fprime is 0, abort.
        error('fprime is 0')       % the error function prints message and exits
    end
  
    % plot the tangent
    counter = counter + 1;
    t_x = linspace (-4, 4, 10); % Create x vector for tangent
    t_y = fpc*(t_x - c) + fc;   % Calculate y vector for tangent
    subplot(4,2,counter)        % Create subplot
    plot(p_x, p_y, 'b-', t_x, t_y, 'r-');   % Plot tangent with function
    axis([-4 4 -1.25 1.25])
    title("Plot of f(x) with tangent at x" + (counter-1) + ".")
    grid('on');
    xlabel('x'); 
    ylabel('f(x)');
    % disp('...press enter to continue') % Pausing for debugging
    % pause on; pause;

    fprintf('x%d:  c=%d, fc=%d, error=%d\n',counter-1,c,fc,abs(2-c))
    c = c - fc/fpc;               %% Newton step
    fc = f(c);
end
end


%%
%% put subroutines here
%%
%%
function fx = f(x)
	fx = tanh(x); %% Enter your function here.
	return;
end

function fprimex = fprime(x)
	fprimex = (sech(x))^2; %% Enter the derivative of your function here.
	return;
end


%%After observing the plot of x0 = 1.08, the tangent bounce around in
%%between each iterations but eventually bring out the solution at x=0
%%which is tangent line. On the other hand, the plot of x0 = 1.09, we found
%%that even though the tangent line may came close to it, at last it moved
%%further away from the line (solution) which Newton method fails. 



