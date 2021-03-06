% March 5, 2021
% Code heavily based off of sample file provided on iLearn
% Amber Hartigan (primary coder), Adrian Lopez, Nyan Tun, Alyssa Reyes,
% and Mark Kim

function [y,itc] = secant_method(x0, x1, TOL, Nmax )

%SECANT_METHOD     approximate the root of an arbitrary function using 
%                  secant method
%
%     calling sequences:
%             y = secant_method( f, x0, x1, TOL, Nmax )
%              secant_method( f, x0, x1, TOL, Nmax )
%
%     inputs:
%             f       the function whose root is to determine
%             x0,x1   left and right endpoints, respectively, of initial interval
%             TOL     absolute error convergence tolerance
%             NMax    maximum number of iterations to be performed
%
%     output:
%             y       approximate value of root
%             itc     number of iterations needed for convergence
%

f_x0 = f(x0); 
f_x1 = f(x1);
itc = 0;
h_x = linspace (-4, 4); 
h_y = f(h_x);
s_x = linspace (-4, 4);
fig1 = figure('position',[ 0 0 1000 1000 ]);
movegui(fig1, 'center');
n = [0;1]; xn = [x0; x1]; f_xn = [f_x0; f_x1];
T = table(n,xn,f_xn);

while abs(f_x1) > TOL && itc < Nmax
    dx = (f_x1 - f_x0)/(x1-x0);
    if dx == 0
        T
        error("Error: dx is zero between x%d = %.3f and x%d = %.3f.", height(T)-2, x0, height(T)-1, x1);
    else
        x = x1 - f_x1/dx;
    end
    if itc <= 7
        subplot(4,2,itc+1)% itc/2+1)
        s_y = ((f_x1 - f_x0)/(x1 - x0))*(s_x - x1) + f_x1;
        plot(h_x, h_y, 'b-', s_x, s_y, 'r-');
        title("Plot of f(x) with secant at x" + (itc) + ".")
        grid('on');
        xlabel('x'); 
        ylabel('f(x)');
    end
    % disp('...press enter to continue')
    % pause on; pause;
    x0   = x1;     x1 = x;
    f_x0 = f_x1; f_x1 = f(x1); 
    itc = itc + 1;
    newRow = {itc+1, x1, f_x1};
    T = [T; newRow];
end
T
% y = x1;
% if abs(f_x1) > TOL
%     
%     itc = -1;
% end

function fx = f(x)
%	%% Enter your function here.
       fx = tanh(x); 
	return;