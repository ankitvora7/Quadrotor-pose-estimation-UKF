function [poseacc] = computePoseFromAccelerometer(zacc)

% Compute angles from accelerometer
pitch = atan2(-zacc(1),sqrt(zacc(2)^2 + zacc(3)^2));
roll = atan2(zacc(2),sqrt(zacc(1)^2 + zacc(3)^2));
yaw = acos(zacc(1));
poseacc = [yaw;pitch;roll];
end

