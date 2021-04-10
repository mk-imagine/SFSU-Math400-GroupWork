function [y,x] = LUFactor(L, U, b)
[nrow,ncol] = size(L);
y=zeros(1, nrow);
y(1) = b(1);
for i = 2:nrow
    T = zeros(1, i);
    T(i) = b(i);
    for j = 1 : i-1
        T(j) = -(L(i,j)*y(j));
    end
    y(i) = sum(T);
end

c = y.';
[nrow,ncol] = size(U);
x(nrow) = c(nrow) / U(nrow, nrow);
for i = nrow - 1 : -1 : 1
    x(i) = ( c(i) - sum ( x(i+1:nrow) .* U(i, i+1:nrow) ) ) / U(i,i);
end

end