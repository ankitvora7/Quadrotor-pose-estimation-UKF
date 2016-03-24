function [Rx] = rotXaxis(theta)

% Computes a rotation matrix for a rotation about X axis
% theta is in radians
Rx = [1 0 0;...
      0 cos(theta) -sin(theta);...
      0 sin(theta) cos(theta)];

end

