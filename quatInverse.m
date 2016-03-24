function [n] = quatInverse(q)
% Computes the inverse of a quaternion

magSquare = norm(q)^2;
n = q./magSquare;
n(2) = -n(2); n(3) = -n(3); n(4) = -n(4);

end

