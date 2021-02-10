
% Problem 5
%
% February 10, 2021
% Group 2: Mark Kim, Amber Hardigan, Adrian Lopez, Nyan Tun, Alyssa Reyes


% plot the ellipse
 x = [-2 : 0.01 : 2]; y = sqrt(1 - x.^2/4);
 plot(x,y,-x,-y);
 hold on
% plot 1000 random points in the ellipse and count how many landed inside
 inside = 0; 
 for counter = 1:1000
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
 area = inside / 1000 * 8;
 
 outside = 1000-inside; 
 
 %estimate the expected mean and variance of Xi
 mean = inside/1000 * 1 + outside/1000 * 0; 
 expectedArea = inside/1000 * 1^2 + outside/1000 * 0^2;
 variance = expectedArea - mean^2;