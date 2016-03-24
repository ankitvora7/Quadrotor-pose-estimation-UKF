function [idx] = getSynchronizedTime(t,timu)
% Compute the index number corresponding to camera timestamp

diff = abs(timu - repmat(t,1,size(timu,2)));
[~,idx] = min(diff);

end

