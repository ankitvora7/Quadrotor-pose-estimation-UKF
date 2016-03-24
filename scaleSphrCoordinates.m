function [newAzi, newEle] = scaleSphrCoordinates(azi,ele)

newAzi = 800 - floor(800.*azi./(pi));
newEle = 400 - floor(400.*ele./(pi));

end