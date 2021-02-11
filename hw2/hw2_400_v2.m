
% Problem 5
%
% February 10, 2021
% Group 2: Mark Kim, Amber Hardigan, Adrian Lopez, Nyan Tun, Alyssa Reyes


% plot the ellipse
a = 2;
b = 1;
x0 = 0;
y0 = 0;
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
 inside = 0; 
 npts = 1000;
 for counter = 1:npts
    % pick a random point in [-2,2]x[-1,1]
    x = 4*rand - 2;  y = 2*rand - 1;
    % plot the point
    plot(x,y, '.r', -x, -y);
    % check if the point is inside the ellipe
    % count the number of points inside the ellipse 
    if (x^2 / 4 + y^2 <= 1)
        inside = inside + 1;
    end
 end

 %estimate the area inside the ellipse 
 area = inside / npts * 8;
 
 outside = npts-inside; 
 
 %estimate the expected mean and variance of Xi
 mean = inside/npts * 1 + outside/npts * 0; 
 expectedArea = inside/npts * 1^2 + outside/npts * 0^2;
 variance = expectedArea - mean^2;