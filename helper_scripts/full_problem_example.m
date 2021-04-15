% Original A and b matrices
A = [6.099 4.324 23.20 1.578; 
    0.4371 3.916 1.683 2.852; 
    4.623 0.8926 15.32 5.305;
    0.2115 2.296 2.715 3.215]
b = [35.20 8.888 26.14 8.438 ].'

% Solve for x, and find L and U matrices
[x, L, U] = gauss_elim(A, b)

% % LU Factorization with original b vector
% [y, x] = LUFactor(L, U, b)
% 
% % LU Factorization with new b2 vector
% b2 = [-3 0 7 8].'
% [y2, x2] = LUFactor(L, U, b2)