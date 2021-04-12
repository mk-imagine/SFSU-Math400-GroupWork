% Original A and b matrices
A = [1 -2 -4 -3; 2 -7 -7 -6; -1 2 6 4; -4 -1 9 8]
b = [1 7 0 3].'

% Solve for x, and find L and U matrices
[x, L, U] = gauss_elim(A, b)

% LU Factorization with original b vector
[y, x] = LUFactor(L, U, b)

% LU Factorization with new b2 vector
b2 = [-3 0 7 8].'
[y2, x2] = LUFactor(L, U, b2)