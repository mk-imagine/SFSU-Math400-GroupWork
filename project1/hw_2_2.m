% March 5, 2021
% Code heavily based off of sample file provided on iLearn
% Adrian Lopez (primary coder), Amber Hartigan, Nyan Tun, Alyssa Reyes,
% and Mark Kim

f = @(x,y,z) x^4 + y^2 + z^2        % Define the function 
volume = 2*2*2;                     % Volume of solid where points are generated
N = input('Enter number of sample points: ');
int = 0;                            % initialize integral
fval = zeros(N,1); 
for i=1:N                           % Loop over sample points
    % Generate a point in the region (parallelepiped)
    x = 2*rand - 1;
    y = 2*rand - 1;
    z = 2*rand - 1;
    if x^2 + y^2 + z^2 <= 1         % Check if within integration region
        temp = f(x,y,z);
        fval(i) = temp;
        int = int + temp;
    end
end

avgf = int/N;                       % Average of the function
int = volume*avgf;                  % Approximation of the integral
confidence=volume*std(fval)/sqrt(N);% Confidence
conf_interval = [int-confidence, int+confidence]; % Confidence Interval
fprintf("Estimate for integral is:         %.5f\n",int);
fprintf("With standard deviation:          %.5f\n",confidence);
fprintf("With a confidence interval of:  [ %.5f, %.5f ]\n",conf_interval);