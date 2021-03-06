% March 5, 2021
% Code heavily based off of sample files provided on iLearn
% Mark Kim (primary coder), Amber Hartigan, Nyan Tun, Alyssa Reyes,
% and Adrian Lopez

function c = bisect_newton(a, b, delta, s)
    arguments
        a (1,1) {mustBeNumeric,mustBeReal}
        b (1,1) {mustBeNumeric,mustBeReal}
        delta (1,1) double
        s (1,1) double = 0.1
    end
    init_a = a;
    init_b = b;
    fa = f(a); 			%% compute initial values of f(a) and f(b)
    fb = f(b); 

    if  sign(fa) == sign(fb)	% sanity check: if f(a) and f(b) have the same sign
        % error thrown below
        error('f must have different signs at the endpoints a and b.  Aborting.')
    end
    fprintf('initial interval:  a=%d, b=%d, fa=%d, fb=%d\n',a,b,fa,fb) % print initial interval
    
    % Set up plots
    p_vector = zeros(2, 2);
    labels = zeros(2,1);
    counter = 1;

    while abs(b-a) >= abs(s*(init_b-init_a))
        c = (b + a)/2;		%% Set c to be the midpoint of the interval
        fc = f(c);		%% Calculate the value of f at c
        p_vector(counter, 1) = c;
        p_vector(counter, 2) = fc;
        labels(counter) = counter;
        if sign(fc) ~= sign(fb)
            a = c; 	fa = fc;
        else 
            b = c;	fb = fc;
        end
        counter = counter + 1;
        fprintf('   a=%d, b=%d, fa=%d, fb=%d\n',a,b,fa,fb)
    end
    
    % Plot Bisections
    p_x = linspace(-4, 4, 100);
    p_y = f(p_x);
    fig1 = figure('position',[ 0 0 700 1000 ]); % Size figure
    movegui(fig1, 'center');                    % Position figure in center of screen
    subplot(4,2,[1,2]);
    plot(p_x, p_y, 'b-');
    title("Plot of f(x) with iterative bisections.");
    grid on;
    hold on;
    labels = cellstr( num2str(labels));
    plot(p_vector(:,1),p_vector(:,2), 'rx');
    text(p_vector(:,1),p_vector(:,2), labels, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
    
    nc = 1;
    while abs(fc) > delta % Continue until evaluation satisfies convergence criterion
        fpc = f1x(c);        % Calculate derivative at current step

        if fpc==0                      % if fprime is 0, abort.
            error('fprime is 0')       % the error function prints message and exits
        end

        % plot the tangent
        t_x = linspace (-4, 4, 10); % Create x vector for tangent
        t_y = fpc*(t_x - c) + fc;   % Calculate y vector for tangent
        subplot(4,2,nc+2)        % Create subplot
        plot(p_x, p_y, 'b-', t_x, t_y, 'r-');   % Plot tangent with function
        axis([-4 4 -1.25 1.25])
        title("Plot of f(x) with tangent at x" + (counter) + ".")
        grid('on');
        xlabel('x'); 
        ylabel('f(x)');
        counter = counter + 1;
        nc = nc + 1;
        % disp('...press enter to continue') % Pausing for debugging
        % pause on; pause;

        fprintf('x%d:  c=%d, fc=%d, error=%d\n',counter-1,c,fc,abs(2-c))
        c = c - fc/fpc;               %% Newton step
        fc = f(c);
    end
end

function fx = f(x)
    fx = tanh(x);
    return;
end

function f1x = f1x(x)
    f1x = (sech(x))^2;
    return;
end