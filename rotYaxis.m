function [Ry] = rotYaxis(theta)

% Computes a rotation matrix for a rotation about Y axis
% theta is in radians
Ry = [cos(theta) 0 sin(theta);...
      0 1 0;...
      -sin(theta) 0 cos(theta)];
  
end

