function [Y] = computeProcessModel(X,dt)
% Compute and apply process model

% Extract pose and omega from X 
Xpos = X(1:4,:); Xomg = X(5:7,:);

% Compute process model for pose and omega for each sigma point
numpoints = size(X,2);

for i=1:numpoints
    alpha = norm(Xomg(:,i))*dt; ecc = normc(Xomg(:,i));
    qDelta = [cos(alpha/2);ecc.*sin(alpha/2)];
    Xnewpos = quatMultiply(Xpos(:,i),qDelta);
    Xnewomg = Xomg(:,i);    

    % Combine to form 7x1 state vector
    Y(:,i) = [Xnewpos;Xnewomg];
end

