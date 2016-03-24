clear all
close all
load('./cam1.mat');
load('../vicon/viconRot1.mat')
viconData = rots;
for i=1:size(cam,4)
    i
    im = cam(:,:,:,i);
    subplot(2,1,1)
    imshow(im);        
    theta = 0;
    rotMat = [cosd(theta) -sind(theta) 0;sind(theta) cosd(theta) 0;0 0 1];
    angles = rotm2eul((viconData(:,:,3*i)*rotMat),'ZYX');
    hold on
    subplot(2,1,2)
    plot(i,angles(2),'r+');
    pause(0.005)
    
end