function [xk,Pk,W] = computeMeanCovar(Y,Xk_1)

% Computes mean and covariance of transformed sigma points

numpoints = size(Y,2);
Ypose = Y(1:4,:); Yomg = Y(5:end,:);

% Compute quaternion mean
qbar = computeAvgQuaternion(Ypose,Xk_1);

% Compute ang vel mean
wbar = mean(Yomg,2);

% Merge
xk = [qbar;wbar];

% Computing covariance
ww = Yomg - repmat(wbar,1,numpoints);
qbarinv = quatInverse(qbar);
for i=1:numpoints
    rwquat(:,i) = quatMultiply(Ypose(:,i),qbarinv);
end
rw = quat2vect(rwquat);
W = [rw;ww];
% W = real(W);
Pk = (W*W')/(numpoints);

end

