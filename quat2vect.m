function [vect] = quat2vect(quat)
% Converts a vector to a quaternion

% numbr of quats
n = size(quat,2);
for i=1:n
    
    % Compute vect using alpha and e
    alpha = 2*acos(quat(1,i)); ecc = quat(2:end,i)/(sqrt(1-power(quat(1,i),2)+eps));
    vect(:,i) = ecc.*alpha;
end

