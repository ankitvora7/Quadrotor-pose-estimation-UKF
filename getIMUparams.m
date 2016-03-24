function [imuParams] = getIMUparams()
%Calculate parameters like Scale Factor and bias
%   Detailed explanation goes here
imuParams = struct;
imuParams.Voltage = 3300; % mv
imuParams.Bits = 1023; 
sensitivityGyr = 3.33; % mv/(degree/s)
sensitivityAcc = 330 ; % mv/g
imuParams.sensGyr = sensitivityGyr*180/pi; % mv/(rad/s)
imuParams.sensAcc = sensitivityAcc; % mv/g
imuParams.biasAcc = [-510.1975 -501.7850 504.535]';
imuParams.biasGyr = [373.6460 375.3760 369.6480]';
end

