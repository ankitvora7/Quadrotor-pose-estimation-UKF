function [W] = computeNoiseSigmaPoints(n, Pk_1, Q, dt)
% Computes noise sigma points

A = Pk_1 + Q;

% Cholesky decomposition
S = chol(A);

% Multiply S with +-sqrt(2*n) to get 2n vector set
W = [S.*sqrt(2*n) S.*-sqrt(2*n)];

end

