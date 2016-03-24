function [X] = computeStateSigmaPoints(Xk_1, Wsigma)
% Computes state sigma points

% Split Xk-1 into quat and omega components
qk_1 = Xk_1(1:4); wk_1 = Xk_1(5:end);

% First 3 components of Wsigma affects pose and last 3 components affect
% angular velocity
Wpos = Wsigma(1:3,:); Womg = Wsigma(4:end,:);

% Convert Wpose to quaternions
Wposequat = vect2quat(Wpos);

% Compute sigma points 
numpoints = size(Wsigma,2);
for i=1:numpoints
    xQuat = quatMultiply(qk_1,Wposequat(:,i));     
    xOmega = wk_1 + Womg(:,i);
    X(:,i) = [xQuat;xOmega];
end

