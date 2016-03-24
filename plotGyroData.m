clear all
clc
close all
load('./imu/imuRaw8.mat');
init;
xk = [1 0 0 0]';
tnow =0; tprev = 0;
allposGyr = [0 0 0]';
for i=1:size(vals,2)
    i
    tnow = ts(i);
    dt = tnow-tprev;
    tprev = tnow;
    if i==1
        continue
    end
    z = processIMUData(vals(:,i),imuParams);
    zomg = z(4:end);
    alpha = norm(zomg)*dt; ecc = normc(zomg);
    qDelta = [cos(alpha/2);ecc.*sin(alpha/2)];
    xk_new = quatMultiply(xk,qDelta);
    posGyr = quat2eul(xk_new','ZYX');
    posAcc = computePoseFromAccelerometer(z(1:3));
    xk = xk_new;
    allposGyr(:,i) = posGyr;
    allposAcc(:,i) = posAcc;
    allgVect(:,i) = z(1:3);
end


% Convert vicon data to euler angles to check your values
load('./vicon/viconRot8.mat');
[actualAngles,actualgVect] = computeViconAngles(rots);


% Plot to see values
subplot(3,2,1)  
plot(1:size(allposGyr,2),allposGyr(1,:))
hold on
plot(1:size(actualAngles,2),actualAngles(1,:));
title('Yaw plot')
legend('Gyro', 'Vicon')
axis on
grid on

subplot(3,2,3)  
plot(1:size(allposGyr,2),allposGyr(2,:))
hold on
plot(1:size(actualAngles,2),actualAngles(2,:));
title('Pitch plot')
legend('Gyro', 'Vicon')
axis on
grid on

subplot(3,2,5)  
plot(1:size(allposGyr,2),allposGyr(3,:))
hold on
plot(1:size(actualAngles,2),actualAngles(3,:));
title('Roll plot')
legend('Gyro', 'Vicon')
axis on
grid on

subplot(3,2,2)  
plot(1:size(allposAcc,2),allposAcc(1,:))
hold on
plot(1:size(actualAngles,2),actualAngles(1,:));
title('Yaw data')
legend('Accelero', 'Vicon')
axis on
grid on

subplot(3,2,4)  
plot(1:size(allposAcc,2),allposAcc(2,:))
hold on
plot(1:size(actualAngles,2),actualAngles(2,:));
title('Pitch data')
legend('Accelero', 'Vicon')
axis on
grid on

subplot(3,2,6)  
plot(1:size(allposAcc,2),allposAcc(3,:))
hold on
plot(1:size(actualAngles,2),actualAngles(3,:));
title('Roll data')
legend('Accelero', 'Vicon')
axis on
grid on

% subplot(3,2,2)  
% plot(1:size(allgVect,2),allgVect(1,:))
% hold on
% plot(1:size(actualgVect,2),actualgVect(1,:));
% title('X component of Gravity vector (gx) in body frame')
% legend('Accelero', 'Vicon')
% axis on
% grid on
% 
% subplot(3,2,4)  
% plot(1:size(allgVect,2),allgVect(2,:))
% hold on
% plot(1:size(actualgVect,2),actualgVect(2,:));
% title('Y component of Gravity vector (gy) in body frame')
% legend('Accelero', 'Vicon')
% axis on
% grid on
% 
% subplot(3,2,6)  
% plot(1:size(allgVect,2),allgVect(3,:))
% hold on
% plot(1:size(actualgVect,2),actualgVect(3,:));
% title('Z component of Gravity vector (gz) in body frame')
% legend('Accelero', 'Vicon')
% axis on
% grid on