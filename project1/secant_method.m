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
while abs(f_x1) > TOL && itc < Nmax
    try
        dx = (f_x1 - f_x0)/(x1-x0);
        x = x1 - f_x1/dx;
    catch
        fprintf('Error! - derivative zero for x = %.8f\n', x0)
    end

    x0   = x1;     x1 = x;
    f_x0 = f_x1; f_x1 = f(x1); 
    itc = itc + 1;
    [x f_x1]
end

y = x1;
if abs(f_x1) > TOL
    itc = -1;
end

function fx = f(x)
%	%% Enter your function here.
       fx = 2*sin(x)-exp(x)/4-1; 
	return;