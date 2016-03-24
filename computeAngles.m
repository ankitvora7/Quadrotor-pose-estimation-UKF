function [angles] = computeAngles(vals,previousAngles,dt)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
imuParams = getIMUparams();
rawvalsAcc = vals(1:3,:);
rawvalsGyr = vals(4:6,:);
rAcc = (((rawvalsAcc-imuParams.biasAcc)*imuParams.Voltage/imuParams.Bits)-imuParams.zeroAcc)/imuParams.sensAcc; % unit = g
rGyr = (((rawvalsGyr-imuParams.biasGyr)*imuParams.Voltage/imuParams.Bits)-imuParams.zeroGyr)/imuParams.sensGyr; % unit = rad/s
% rGyrX = rGyr(2);rGyrY = rGyr(3); rGyrZ = rGyr(1);rGyr = [rGyrX;rGyrY;rGyrZ];
normalizedrAcc = normc(rAcc);
normalizedrAcc(1:3,:) = normalizedrAcc(1:3,:).*-1;
anglesAcc = acos(normalizedrAcc);
if nargin<3
    angles = anglesAcc;
%     angles = [0 0 0]';
    return
end
anglesGyro = rGyr.*dt;
angles = 0.98*(previousAngles+anglesGyro)+0.02*anglesAcc;
angles = anglesAcc;
% angles = previousAngles + anglesGyro;
end

