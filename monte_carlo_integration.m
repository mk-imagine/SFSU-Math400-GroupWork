% Monte Carlo Integration
% h.a. boateng
% February 7, 2021
% MATH 400


mult=100; % multiplier

nexpts = 4; % number of experiments
npts = 100;  % number of points generated (initial)
ev = zeros(4,2);  % approximation to integral and standard deviation

for i=1:nexpts
    x=rand(npts,1); y=rand(npts,1); % generate points in [0,1] x [0,1]
    nhits   = (x.^2 + y.^2 <=1);    % points in quarter circle
    ev(i,1) = 4.0*mean(nhits);      % approximation to pi
    ev(i,2) = 4.0*std(nhits)/sqrt(npts);       % Standard deviation in approximation
    
    npts    = mult*npts;
end

%{
% Example 2: integrating f(x,y) = e^(x^2+y^2) over the region x^2 + y^2 = 4

f = @(x,y) exp(x.^2 + y.^2);
a = -2; b = 2; 
area = 16;
N = input('Enter number of sample points: ');
int = 0;                % initialize integral
fval = zeros(N,1);
for i=1:N               % Loop over sample points
    % Generate a point in the square that contains the circle
    x = a + (b-a)*rand; y = a + (b-a)*rand;
    if x^2 + y^2 <= 4 % Check if point is in the cirlce
        temp = f(x,y);
        fval(i) = temp;
        int = int + temp;
    end
end

int = area*int/N;
confidence=area*std(fval)/sqrt(N);
sprintf('Estimate for integral is %15.5f\n',int)
sprintf('With standard deviation %15.5f\n',confidence)

%}