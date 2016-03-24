function [quat] = vect2quat(vect)
% Converts a vector to a quaternion

% number of vectors
n = size(vect,2);

for i=1:n
    % Compute quat using alpha and e
    alpha = norm(vect(:,i)); ecc = normc(vect(:,i));
    quat(:,i) = [cos(alpha/2);ecc.*sin(alpha/2)];
end

