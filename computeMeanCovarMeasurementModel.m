function [zk,Pzz] = computeMeanCovarMeasurementModel(Z,Zk_prev)
% Compute mean and covariance of measurement model transformed points

numpoints = size(Z,2);

% Compute mean
% Zquat = vect2quat(Z(1:3,:));
% Zomg = Z(4:6,:);
% ZmeanOmg = mean(Zomg,2);
% Znew = [Zquat;Zomg];
% Zk_prevQuat = vect2quat(Zk_prev(1:3));
% Zk_prev = [Zk_prevQuat;Zk_prev(4:6)];
% Zmean = computeAvgQuaternion(Znew,Zk_prev);
% ZmeanVect = quat2vect(Zmean(1:4));
zk = mean(Z,2);

% Compute covar
Pzz = (Z-repmat(zk,1,numpoints))*(Z-repmat(zk,1,numpoints))'/(numpoints);

end

