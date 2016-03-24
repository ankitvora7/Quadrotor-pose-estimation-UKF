function q2 = q_getPositive(q)
%Q_GETPOSITIVE Equivalent positive quaternion.
%   Q2 = Q_GET_POSITIVE(Q) return a quaternion Q2 describing the same
%   rotation as Q, but ensures that its first element is always positive
%   (Q2(1) >= 0).

%   Author: Damien Teney

if q(1) >= 0
  q2 = q;
else
  q2 = -q;
end
