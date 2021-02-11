mult = 100;         % multiplierev

nexpts = 4;         % number of experiments
npts = 100;         % number of points generated (initial)
ev = zeros(4,3);    % approximation to integral and standard deviation

for i=1:nexpts
    x=rand(npts,2); y=rand(npts,1);         % generate points in [0,2] x [0,1]
    if (x^2 / 4 + y^2 <= 1)
        inside = inside + 1;
    else
        outside = outside + 1;
end