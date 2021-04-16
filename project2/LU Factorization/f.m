function [p] = f()
syms s t;
f = exp(-(s^2+t^2));
fx = diff(f, s);
fy = diff(f, t);
fxy = diff(fx, t);

x = [ 0 0; 1 0; 0 1; 1 1]

p = zeros(16, 1);
for i=0:3
    p(4*i+1) = vpa(subs(f,[s, t], [x(i+1,1), x(i+1,2)]));
    p(4*i+2) = vpa(subs(fx,[s, t], [x(i+1,1), x(i+1,2)]));
    p(4*i+3) = vpa(subs(fy,[s, t], [x(i+1,1), x(i+1,2)]));
    p(4*i+4) = vpa(subs(fxy,[s, t], [x(i+1,1), x(i+1,2)]));
end
p
end