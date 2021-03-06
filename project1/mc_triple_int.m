% February 10, 2021
% Example from book: integrating f(x,y,z) = cos(xye^z) over the region   0
% 0<= x <=1, x <= y <= 1, xy <= z <= 2

f = @(x,y,z) x^4 + y^2 + z^2 % Define the function 
volume = 2*2*2;
N = input('Enter number of sample points: ');
int = 0;                % initialize integral
fval = zeros(N,1); 
for i=1:N               % Loop over sample points
    % Generate a point in the region (parallelepiped)
    x = 2*rand - 1; y = 2*rand - 1; z = 2*rand - 1;
    if x^2+y^2+z^2 <= 1 % Check if integration region
        temp = f(x,y,z);
        fval(i) = temp;
        int = int + temp;
    end
end

avgf = int/N; % Average of the function
int = volume*avgf; % Approximation to the integral
confidence=volume*std(fval)/sqrt(N);
sprintf('Estimate for integral is %15.5f\n',int)
sprintf('With standard deviation %15.5f\n',confidence)