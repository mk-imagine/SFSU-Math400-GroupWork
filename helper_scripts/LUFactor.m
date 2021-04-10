% LU Factorization Script
% 
%     calling sequences:
%             [y,x] = LUFactor ( L, U, b )
%
%     inputs:
%             L       L Matrix
%             U       U Matrix
%             b       right-hand side vector
%
%     output:
%             y       Solution vector from Ly=b (forward substitution)
%             x       Solution vector from Ux=y (back substitution)


function [y,x] = LUFactor(L, U, b)
[nrow,ncol] = size(L);

% Forward Substitution
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

% Back Substitution
c = y.';
[nrow,ncol] = size(U);
x(nrow) = c(nrow) / U(nrow, nrow);
for i = nrow - 1 : -1 : 1
    x(i) = ( c(i) - sum ( x(i+1:nrow) .* U(i, i+1:nrow) ) ) / U(i,i);
end

end