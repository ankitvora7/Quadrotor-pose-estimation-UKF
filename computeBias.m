% Compute bias for acc and gyro
load('./imu/imuRaw1.mat');
init;

% Number of initial points you want to consider for bias
numStationaryPoints = 1500;

% Compute the mean of those values
for i=1:numStationaryPoints
    z(:,i) = processIMUData(vals(:,i),imuParams);
end

% Find the mean of observed values
rawZ = mean(vals(:,1:numStationaryPoints),2);

% use hit and trial to get ideal state values with 0 bias
rawIdeal = [511.5 511.5 606 381.5 381.5 381.5]';

bias = rawZ-rawIdeal;
