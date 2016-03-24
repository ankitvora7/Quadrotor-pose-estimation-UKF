function [transformedAngles] = transformToViconFrame(angles)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
frame = eul2rotm(angles');
rotMat = [0 1 0;0 0 -1;-1 0 0]';
finalMat = frame*rotMat;
transformedAngles = rotm2eul(finalMat);

end

