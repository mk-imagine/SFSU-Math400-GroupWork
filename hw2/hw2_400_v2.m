% Problem 5
%
% February 10, 2021
% Group 2: Mark Kim, Amber Hartigan, Adrian Lopez, Nyan Tun, Alyssa Reyes

% Initial Assumptions
% x^2/a^2 + y^2/b^2 = 1
a = 2; b = 1;               % Parameters of Ellipse
areaRectangle = 2*a * 2*b;  % Area of the rectangle
areaEllipse = pi * a * b;   % Area of the Ellipse

% Parametric plot of the ellipse
t = -pi:0.1:pi;
x = a*cos(t);
y = b*sin(t);
figure(1); clf; 
plot(x,y,'b','linewidth',1)
set(gca, 'fontsize', 12)
xlabel('X')
ylabel('Y')
grid on
hold on

% plot 1000 random points in the ellipse and count how many landed inside
inside = 0; outside = 0;    % Initialize & declare point counts
npts = 1000;                % Number of points to be generated/plotted
for counter = 1:npts
    % pick a random point in [-2,2]x[-1,1]
    x = 4*rand - 2;  y = 2*rand - 1;
    % plot the point
    plot(x,y, '.r', -x, -y);
    % check if the point is inside the ellipe
    if (x^2 / 4 + y^2 <= 1)
        inside = inside + 1;    % count the number of points inside the ellipse 
    else
        outside = outside + 1;  % count the number of points outside the ellipse 
    end
end

fprintf('The estimated number of points indide the ellipse are');
disp(inside);

% estimate the area inside the ellipse 
area = inside / npts * areaRectangle;   % percentage of points inside * area of the rectangle
fprintf('The estimated area inside the ellipse is %f' ,area);

% part C estimate the expected mean and variance of Xi
mean = inside/npts * 1 + outside/npts * 0;
fprintf('\n The estimated mean of X_i is %s' ,mean);

expectedArea = inside/npts * 1^2 + outside/npts * 0^2;

variance = expectedArea - mean^2;
fprintf('\n The estimated variance of X_i is %s' ,variance);

% part d
estimatedMean = mean;
fprintf('\n The estimated mean of the plotted points is %s' ,estimatedMean);

estimatedVariance =  variance/1000;
fprintf('\n The estimated variance of the plotted points is %s' ,estimatedVariance);

standardDeviation = sqrt(estimatedVariance);
fprintf('\n The standard deviation of the plotted points is %s' ,standardDeviation);


% part e
estimatedMean8A = 8 * mean;
fprintf('\n The estimated mean of 8A_1000 is %s' ,estimatedMean8A);

estimatedVariance8A =  64 * variance/1000;
fprintf('\n The estimated variance of 8A_1000 is %s' ,estimatedVariance8A);

standardDeviation8A = sqrt(estimatedVariance8A);
fprintf('\n The standard deviation of 8A_1000 is %s' ,standardDeviation8A);

confidence = (1 - standardDeviation8A) * 100
fprintf('\n Based off of the standard deviation results, we are around .1 percent  off; thus, we have 90 percent confidence.')