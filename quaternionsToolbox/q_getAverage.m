function qAverage = q_getAverage(qs)
%Q_GETAVERAGE Average (approximation) of several quaternions.
%   QAVERAGE = Q_GETAVERAGE(QS) returns an approximation of the average of
%   several quaternions (Nx4). The interpolation is linear in R4 but not on
%   the sphere (we should otherwise use SLERP), but this approximation
%   works fine if the given quaternions are close one to each other.

%   Author: Damien Teney

nQuaternions = size(qs, 1);

% Get positive quaternions
for i = 1:nQuaternions
  qs(i, 1:4) = q_getPositive(qs(i, 1:4));
end

qAverage = sum(qs, 1);
qAverage = q_getUnit(qAverage);
