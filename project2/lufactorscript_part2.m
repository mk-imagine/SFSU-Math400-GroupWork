
% p = alpha(1)+alpha(2)*x+alpha(3)*x^2+alpha(4)*x^3+alpha(5)*y+alpha(6)*y^2+alpha(7)*y^3
% +alpha(8)*x*y+alpha(9)*x^2*y+alpha(10)*x^3*y+alpha(11)*x*y^2+alpha(12)*x^2*y^2+alpha(13)*x^3*y^2
% +alpha(14)*x*y^3+alpha(15)*x^2*y^3+alpha(16)*x^3*y^3;

syms x y;  % symbolic representation for x and y
%% functions to be evaluated
f1 = exp(-(x^2+y^2));
f1x = diff(f1,x);
f1y = diff(f1,y);
f1xy = diff(f1x,y);

f2 = tanh(x*y);
f2x = diff(f2,x);
f2y = diff(f2,y);
f2xy = diff(f2x,y);

%% v is the x,y vector of polynomial terms
v = [1, x, x^2, x^3, y, y^2, y^3, x*y, x^2*y, x^3*y, x*y^2, x^2*y^2, x^3*y^2, x*y^3, x^2*y^3, x^3*y^3].';
vx = diff(v, x);
vy = diff(v, y);
vxy = diff(vx, y);
B = zeros(16, 16);

%% conditions for interpolation
t = [0 0; 1 0; 0 1; 1 1];   % corners of unit square for finding alpha vector (x,y)
u = 0.5;  % evaluation point for last 4 conditions (0.5, 0.5)

%% Calculation of matrix B
for i=1:4
    B(i,:) = subs(v, [x,y], [t(i, 1), t(i, 2)]);
    B(i+4,:) = subs(vx, [x,y], [t(i, 1), t(i, 2)]);
    B(i+8,:) = subs(vy, [x,y], [t(i, 1), t(i, 2)]);
end
B(13,:) = subs(v, [x,y], [u, u]);
B(14,:) = subs(vx, [x,y], [u, u]);
B(15,:) = subs(vy, [x,y], [u, u]);
B(16,:) = subs(vxy, [x,y], [u, u]);

%% LU factorization of matrix B
[lu, pvt, lupivoted] = LUfactor(B);

%% Calculation of solution vector (f) at the points given in assignment
s1 = zeros(16,1);            % solution vector for f(x,y)=exp(-(x^2+y^2))
s2 = zeros(16,1);            % solution vector for f(x,y)=tanh(x*y)
for i=1:4
   % solutions for f(x,y)=exp(-(x^2+y^2))
   s1(i) = subs(f1, [x,y], [t(i, 1), t(i, 2)]); 
   s1(i+4) = subs(f1x, [x,y], [t(i, 1), t(i, 2)]); 
   s1(i+8) = subs(f1y, [x,y], [t(i, 1), t(i, 2)]);
   % solutions for f(x,y)=tanh(x*y)
   s2(i) = subs(f2, [x,y], [t(i, 1), t(i, 2)]); 
   s2(i+4) = subs(f2x, [x,y], [t(i, 1), t(i, 2)]); 
   s2(i+8) = subs(f2y, [x,y], [t(i, 1), t(i, 2)]);
end
s1(13) = subs(f1, [x,y], [u,u]); 
s1(14) = subs(f1x, [x,y], [u,u]); 
s1(15) = subs(f1y, [x,y], [u,u]); 
s1(16) = subs(f1xy, [x,y], [u,u]);

s2(13) = subs(f2, [x,y], [u,u]); 
s2(14) = subs(f2x, [x,y], [u,u]); 
s2(15) = subs(f2y, [x,y], [u,u]); 
s2(16) = subs(f2xy, [x,y], [u,u]);

%% Calculation of the coefficients (alpha) vector
alpha1 = LUsolve(lu, s1, pvt);  % alpha vector (coefficients of the function) for f(x,y)=exp(-(x^2+y^2))
alpha2 = LUsolve(lu, s2, pvt);  % alpha vector (coefficients of the function) for f(x,y)=tanh(x*y)

p1 = alpha1*v; % p(x,y) estimate for f(x,y)=exp(-(x^2+y^2))
p2 = alpha2*v; % p(x,y) estimate for f(x,y)=tanh(x*y)

%% Estimation via interpolation
values_to_estimate = [0.25 0.25; 0.4 0.8; 0.75 0.25; 0.8 0.9];

%% estimation of f1
exact_f1 = zeros(4,1);
estimate_f1 = zeros(4,1);
for i=1:4
   exact_f1(i) = subs(f1, [x,y], [values_to_estimate(i, 1), values_to_estimate(i, 2)]); 
   estimate_f1(i) = subs(p1, [x,y], [values_to_estimate(i, 1), values_to_estimate(i, 2)]); 
end
f1_1norm_err = norm(exact_f1-estimate_f1,1);
f1_2norm_err = norm(exact_f1-estimate_f1);

%estimation of f1x
p1x = diff(p1,x);
exact_f1x = zeros(4,1);
estimate_f1x = zeros(4,1);
for i=1:4
   exact_f1x(i) = subs(f1x, [x,y], [values_to_estimate(i, 1), values_to_estimate(i, 2)]); 
   estimate_f1x(i) = subs(p1x, [x,y], [values_to_estimate(i, 1), values_to_estimate(i, 2)]); 
end
f1x_1norm_err = norm(exact_f1x-estimate_f1x,1);
f1x_2norm_err = norm(exact_f1x-estimate_f1x);

%estimation of f1xy
p1xy = diff(p1x,y);
exact_f1xy = zeros(4,1);
estimate_f1xy = zeros(4,1);
for i=1:4
   exact_f1xy(i) = subs(f1xy, [x,y], [values_to_estimate(i, 1), values_to_estimate(i, 2)]); 
   estimate_f1xy(i) = subs(p1xy, [x,y], [values_to_estimate(i, 1), values_to_estimate(i, 2)]); 
end
f1xy_1norm_err = norm(exact_f1xy-estimate_f1xy,1);
f1xy_2norm_err = norm(exact_f1xy-estimate_f1xy);


%% estimation of f2
exact_f2 = zeros(4,1);
estimate_f2 = zeros(4,1);
for i=1:4
   exact_f2(i) = subs(f2, [x,y], [values_to_estimate(i, 1), values_to_estimate(i, 2)]); 
   estimate_f2(i) = subs(p2, [x,y], [values_to_estimate(i, 1), values_to_estimate(i, 2)]); 
end
f2_1norm_err = norm(exact_f2-estimate_f2,1);
f2_2norm_err = norm(exact_f2-estimate_f2);

%estimation of f2x
p2x = diff(p2,x);
exact_f2x = zeros(4,1);
estimate_f2x = zeros(4,1);
for i=1:4
   exact_f2x(i) = subs(f1x, [x,y], [values_to_estimate(i, 1), values_to_estimate(i, 2)]); 
   estimate_f2x(i) = subs(p2x, [x,y], [values_to_estimate(i, 1), values_to_estimate(i, 2)]); 
end
f2x_1norm_err = norm(exact_f2x-estimate_f2x,1);
f2x_2norm_err = norm(exact_f2x-estimate_f2x);

%estimation of f2xy
p2xy = diff(p2x,y);
exact_f2xy = zeros(4,1);
estimate_f2xy = zeros(4,1);
for i=1:4
   exact_f2xy(i) = subs(f1xy, [x,y], [values_to_estimate(i, 1), values_to_estimate(i, 2)]); 
   estimate_f2xy(i) = subs(p2xy, [x,y], [values_to_estimate(i, 1), values_to_estimate(i, 2)]); 
end
f2xy_1norm_err = norm(exact_f2xy-estimate_f2xy,1);
f2xy_2norm_err = norm(exact_f2xy-estimate_f2xy);
