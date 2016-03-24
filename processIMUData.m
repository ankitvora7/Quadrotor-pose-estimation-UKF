function [z] = processIMUData(val, imuParams)
% Process raw IMU data to get 3x1 acc data in terms of g and 3x1 gyro data
% in terms of rad/s

% Split Acc and Gyro values
rawvalsAcc = val(1:3);
rawvalsGyr = val(4:6);

% Gyro order is [wz, wx, wy]. Making it [wx wy wz]
rawvalsGyr = [rawvalsGyr(2);rawvalsGyr(3);rawvalsGyr(1)];

% Sensor gives reverse acc in X, Y and Z. Reversing the sign
rawvalsAcc(1:2) = rawvalsAcc(1:2).*-1;

% Convert raw values to meaningful values according to instructable IMU
% tutorials. 
rAcc = ((rawvalsAcc-imuParams.biasAcc)*imuParams.Voltage/imuParams.Bits)/imuParams.sensAcc; % unit = g
rGyr = ((rawvalsGyr-imuParams.biasGyr)*imuParams.Voltage/imuParams.Bits)/imuParams.sensGyr; % unit = rad/s



z = [rAcc;rGyr];
end

