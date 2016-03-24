function [Z] = computeMeasurementModel(Y)
% Computes measurement model

numpoints = size(Y,2);

% Split Y into pose and omg
Ypose = Y(1:4,:); Yomg = Y(5:end,:);

% Compute model
zrot = Yomg;
gvect = [0 0 -1]';
gquat = [0;gvect];

for i=1:numpoints
    gtquat = quatMultiply(quatMultiply(Ypose(:,i),gquat),quatInverse(Ypose(:,i)));
    gtvect = gtquat(2:4);
    zacc(:,i) = gtvect;
end

Z = [zacc;zrot];

end

