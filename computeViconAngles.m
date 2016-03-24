function [rotAngles,gVect] = computeViconAngles(viconData)
for i=1:size(viconData,3)
    theta = 0;
    rotMat = [cosd(theta) -sind(theta) 0;sind(theta) cosd(theta) 0;0 0 1];
    gVect(:,i) = viconData(:,:,i)'*[0 0 -1]';
    angles = rotm2eul((viconData(:,:,i)*rotMat),'ZYX');
    rotAngles(:,i) = angles;
end
