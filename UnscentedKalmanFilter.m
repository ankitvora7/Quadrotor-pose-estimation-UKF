function UnscentedKalmanFilter(vals,rots,cam,timu,tvicon,tcam)
% clear
% clc
% close all
init;
% load('./imu/imuRaw9.mat')
% timu = ts;
iter = size(timu,2);
tprev = 0;

% Dimensions
n = 6;

% Initialize the states and covariance matrix
Xk_1 = zeros(7,1); Xk_1(1) = 1;
rangePos = pi/3; rangeVel = 2;
Pk_1 = [rangePos 0 0 0 0 0;...
        0 rangePos 0 0 0 0;...
        0 0 rangePos 0 0 0;...
        0 0 0 rangeVel 0 0;...
        0 0 0 0 rangeVel 0;...
        0 0 0 0 0 rangeVel];

% Initialize process model noise covariance matrix Q
Qa = 10^1.1; Qb = 10^-1;
Q = [Qa 0 0 0 0 0;...
    0 Qa 0 0 0 0;...
    0 0 Qa 0 0 0;...
    0 0 0 Qb 0 0;...
    0 0 0 0 Qb 0;...
    0 0 0 0 0 Qb];

% Initialize measurement noise covariance matrix R
Ra = 1*10^4; Rb = 10^-1;
R = [Ra 0 0 0 0 0;...
     0 Ra 0 0 0 0;...
     0 0 Ra 0 0 0;...
     0 0 0 Rb 0 0;...
     0 0 0 0 Rb 0;...
     0 0 0 0 0 Rb];

newpos = [0 0 0]';
allzobs = [0 0 -1 0 0 0]';
Zk_prev = [1 0 0 0 0 0]';

for i=1:iter
    i
    tnow = timu(i);
    dt = tnow-tprev;
    tprev = tnow;
    
    if i==1
        continue
    end
    % Compute noise sigma points
    Wsigma = computeNoiseSigmaPoints(n, Pk_1, Q, dt);

    % Compute state sigma points
    Xsigma = computeStateSigmaPoints(Xk_1, Wsigma);
    
    % Compute and apply process model
    Ysigma = computeProcessModel(Xsigma, dt);
    
    % Compute mean and covar of transformed sigma points
    [Xk_,Pk_,W] = computeMeanCovar(Ysigma,Xk_1);
        
    % Compute measurement model (predicted)
    Zsigma = computeMeasurementModel(Ysigma);
    
    % Compute mean and covariance of measurement model transformed points
    [Zk_,Pzz] = computeMeanCovarMeasurementModel(Zsigma, Zk_prev);
    Zk_prev = Zk_;
    
    % Compute the innovation term and its covariance
    zobs = processIMUData(vals(:,i), imuParams);
%     allzobs(:,i) = 0.8.*allzobs(:,i-1)+0.2.*zobs;
%     zobs = allzobs(:,i);
    vk = zobs - Zk_;
    Pvv = Pzz + R;
    
    % Compute cross corelation matrix
    Pxz = computeCrossCorrelationMatrix(W,Zsigma,Zk_);
    
    % Compute kalman gain and its equations
    [Xk,Pk] = updateKalman(Pxz,Pvv,vk,Xk_,Pk_);
    
    % Extract euler angles from the state quaternion
    pos(:,i) = quat2eul(Xk(1:4)','ZYX');
    RotMat(:,:,i) = eul2rotm(pos(:,i)','ZYX');

    % Assign new means for the next recursion cylce
    Xk_1 = Xk
    Pk_1 = Pk;
    
    
%     Put a low pass filter on the positions
%     newpos(:,i) = 0.9*newpos(:,i-1)+0.1*(pos(:,i));    
end

% Convert vicon data to euler angles to check your values
[actualAngles,~] = computeViconAngles(rots);

for i = 1:size(timu,2)
    diff = abs(tvicon - repmat(timu(i),1,size(tvicon,2)));
    [~, idx] = min(diff);
    viconIdx(i) = idx;
end
newpos = pos;
% Plot to see values
subplot(3,1,1)  
plot(1:size(newpos,2),newpos(1,:))
hold on
plot(1:size(viconIdx,2),actualAngles(1,viconIdx));
legend('UKF','Vicon')
title('Yaw data')
axis on
grid on

subplot(3,1,2)  
plot(1:size(newpos,2),newpos(2,:))
hold on
plot(1:size(viconIdx,2),actualAngles(2,viconIdx));
legend('UKF','Vicon')
title('Pitch data')
axis on
grid on

subplot(3,1,3)  
plot(1:size(newpos,2),newpos(3,:))
hold on
plot(1:size(viconIdx,2),actualAngles(3,viconIdx));
legend('UKF','Vicon')
title('Roll data')
axis on
grid on
pause()
disp('Press enter to continue')
close all

% Run Stitching
imageStitching(cam,rots,timu,tcam);