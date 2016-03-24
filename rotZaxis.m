function [Rz] = rotZaxis(theta)

% Computes a rotation matrix for a rotation about Z axis
% theta is in radians
Rz = [cos(theta) -sin(theta) 0;...
      sin(theta) cos(theta) 0;...
      0 0 1];
  
end

