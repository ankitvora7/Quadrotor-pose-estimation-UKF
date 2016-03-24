function [Xk,Pk] = updateKalman(Pxz,Pvv,vk,Xk_,Pk_)

% Compute Kalman gain and update equations
Kk = Pxz*inv(Pvv);
gain = Kk*vk;
gainWithQuat = [vect2quat(gain(1:3));gain(4:end)];

% New mean
xkpos = quatMultiply(Xk_(1:4),gainWithQuat(1:4));
xkomg = Xk_(5:end) + gainWithQuat(5:end);
Xk = [xkpos;xkomg];

% New covariance
Pk = Pk_ - Kk*Pvv*Kk';

end

