function q2 = q_getUnit(q)
%Q_GETUNIT Unit quaternion.
%   Q2 = Q_GETUNIT(q) divides a quaternion Q by its own modulus and returns
%   it.

%   Author: Damien Teney

modulus = sqrt(q_getSquaredModulus(q));
q2 = q ./ modulus;
