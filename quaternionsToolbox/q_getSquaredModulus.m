function n = q_getSquaredModulus(q)
%Q_GETSQUAREDMODULUS Squared modulus of a quaternion.
%   N = Q_GETSQUAREDMODULUS(Q) computes the square of the modulus of Q.

q = q.^2;
n = sum(q);
