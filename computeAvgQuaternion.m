
function [Qavg]=computeAvgQuaternion(Q,Xk_1)

% % Form the symmetric accumulator matrix
% A = zeros(4,4);
% M = size(Q,1);
% 
% for i=1:M
%     q = Q(i,:)';
%     A = q*q'+A; % rank 1 update
% end
% 
% % scale
% A=(1.0/M)*A;
% 
% % Get the eigenvector corresponding to largest eigen value
% [Qavg, Eval] = eigs(A,1);


% thresh = 10^-3;
% qmean = Xk_1(1:4);
% qmeanprev = [0 0 0 0]';
% meanErrorVect = [1 1 1];
% while sum(abs(qmean-qmeanprev)<repmat(thresh,4,1))~=4
%     qmeanprev = qmean;
%     % Initialize the mean as quaternion from previous iteration
%     qmeanInv = quatInverse(qmean);
%     
%     % Compute the error quaternion array
%     for i = 1:size(Q,2)
%         errQuat(:,i) = quatMultiply(Q(:,i),qmeanInv);
%     end
%     errVect = quat2vect(errQuat);
%     meanErrorVect = mean(errVect,2);
%     meanErrorQuat = vect2quat(meanErrorVect);
%     qnew = quatMultiply(meanErrorQuat,qmean);    
%     qmean = qnew;    
% end
% Qavg = qmean;
sumMat = Q*Q';
[V,~] = eig(sumMat);
Qavg = V(:,end);

end
