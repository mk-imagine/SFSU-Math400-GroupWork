% March 5, 2021
% Project 1, Problem 3d
% Code heavily based off of sample files provided on iLearn
% Mark Kim (primary coder), Nyan Tun (primary coder), Amber Hartigan, Alyssa Reyes,
% and Adrian Lopez

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% bisect_newton.m
% 
% Implements a combination of the Bisection Method and Newton's Method.
% Iterates through bisections until it reaches a specified fraction of the
% initial interval (default 0.1), then switches to Newton's Method.  If
% Newton's diverges with the initial specified fraction, this algorithm
% will reduce the fraction by half and continue with the Bisection Method
% before re-attempting Newton's Method.
%
% Input:    a       left endpoint of interval
%           b       right endpoint of interval
%           delta   tolerance/accuracy desired
%           s       fraction of initial interval when bisection switches to
%                   Newton's Method
%
% Output:   c       approximation of root of function
%
% Syntax:   bisect_newton(a, b, delta, s)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Main Function
function c = bisect_newton(a, b, delta, s)
    arguments
        a (1,1) double          % Lower bound of initial interval
        b (1,1) double          % Upper bound of initial interval
        delta (1,1) double      % Tolerance/accuracy desired
        s (1,1) double = 0.1    % Fraction of initial interval when 
                                %   method switches to Newton's Method.
    end
    close all;                  % close all figures on screen
    init_a = a;                 % store initial interval to be evaluated
    init_b = b;
    fa = f(a);                  % compute initial values of f(a) and f(b)
    fb = f(b); 
    zero_fpc = true;            % initialize flag for a zero f prime to enter while loop

    if  sign(fa) == sign(fb)	% sanity check: if f(a) and f(b) have the same sign
        % error thrown below
        error('f must have different signs at the endpoints a and b.  Aborting.')
    end
    
    while zero_fpc == true      % while f prime is zero, redo Bisection with smaller fraction of interval
        
        zero_fpc = false;       % set flag to false so algorithm can complete if f prime does not reach zero
        
        % Set up plots
        p_vector = zeros(2, 2); % initialize vector to store values of c and f(c)
        labels = zeros(2,1);    % label vector for bisection graph
        counter = 1;            % counter for iteration count
        
        %% Bisection Method
        fprintf('Bisection Method:\n');
        fprintf('initial interval:\ta=%d, b=%d, fa=%d, fb=%d\n',a,b,fa,fb) % print initial interval
        while abs(b-a) >= abs(s*(init_b-init_a))
            c = (b + a)/2;		% Set c to be the midpoint of the interval
            fc = f(c);          % Calculate the value of f at c
            p_vector(counter, 1) = c;   % store c and f(c) values in vector
            p_vector(counter, 2) = fc;
            labels(counter) = counter;  % store label numbers
            if sign(fc) ~= sign(fb)
                a = c; 	fa = fc;    % if signs are not equal reassign a to c
            else 
                b = c;	fb = fc;    % otherwise reassign b to c
            end
            counter = counter + 1;
            fprintf('\ta=%d, b=%d, fa=%d, fb=%d\n',a,b,fa,fb)
        end

        % Plot Bisections
        p_x = linspace(-4, 4, 100); % initialize plot of function
        p_y = f(p_x);
        fig1 = figure('position',[ 0 0 700 1000 ]); % Size figure
        movegui(fig1, 'center');                    % Position figure in center of screen
        subplot(3,2,[1,2]);                         % Create subplot of bisection method
        plot(p_x, p_y, 'b-');                       % Plot function
        title("Plot of f(x) with iterative bisections.");
        grid on;
        hold on;
        labels = cellstr( num2str(labels));
        plot(p_vector(:,1),p_vector(:,2), 'rx');    % Plot points from bisection
        text(p_vector(:,1),p_vector(:,2), labels, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');

        nc = 1; % initialize newton counter
        
        %% Newton's Method
        fprintf("Newton's Method:\n");
        while abs(fc) > delta    % Continue until evaluation satisfies convergence criterion
            fpc = f1x(c);        % Calculate derivative at current step

            if fpc==0               % if fprime is 0,
                s = s/2;            % reduce bisection interval fraction to return to bisection
                zero_fpc = true;    % set flag for zero fprime to true
                close(fig1);        % close old figure
                fprintf('\nf prime is zero,\ncontinuing bisection method with smaller fraction of initial interval: s = %f\n\n',s);
                break       % break out of loop and continue bisection with smaller s
            end

            % plot the tangent
            t_x = linspace (-4, 4, 10); % Create x vector for tangent
            t_y = fpc*(t_x - c) + fc;   % Calculate y vector for tangent
            subplot(3,2,nc+2)           % Create subplot
            plot(p_x, p_y, 'b-', t_x, t_y, 'r-');   % Plot tangent with function
            axis([-4 4 -1.25 1.25])     % Set axis for graph readability
            title("Plot of f(x) with tangent at x" + (counter) + ".")
            grid('on');
            xlabel('x'); 
            ylabel('f(x)');
            counter = counter + 1;      % increment total counter
            nc = nc + 1;                 % increment newton counter
            % disp('...press enter to continue') % Pausing for debugging
            % pause on; pause;

            fprintf('\tx%d:  c=%d, fc=%d, error=%d\n',counter-1,c,fc,abs(2-c))
            c = c - fc/fpc;               %% Newton step
            fc = f(c);
        end
    end
end

%% Function to be evaluated
function fx = f(x)
    fx = tanh(x);
    return;
end

%% Derivative of function to be evaluated
function f1x = f1x(x)
    f1x = (sech(x))^2;
    return;
end