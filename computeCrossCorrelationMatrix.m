function Pxz = computeCrossCorrelationMatrix(W,Zsigma,Zk_)

% Computes the cross-correlation matrix

numpoints = size(Zsigma,2);
Pxz = W*(Zsigma-repmat(Zk_,1,numpoints))'/(numpoints);

end

