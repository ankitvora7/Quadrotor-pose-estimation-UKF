function imageStitching(cam,rots,timu,tcam)
% Stitch image
disp('Stitching Image')
newim = zeros(800,1600,3);
for i = 1:15:size(cam,4)    
    idx = getSynchronizedTime(tcam(i),timu);
    if idx>size(rots,3)
        pause(5)
        return
    end
    R = rots(:,:,idx);
    im = cam(:,:,:,i);
    % Generate image/cartesian coordinates
    r = size(im,1); c = size(im,2);
    cartCoord = generateCoordinates(r,c);
    transCoord = R*cartCoord';
    normCoord = normc(transCoord);
    [azi, ele, ~] = cart2sph(normCoord(1,:),normCoord(2,:),normCoord(3,:));
    [scaledAzi,scaledEle] = scaleSphrCoordinates(azi,ele);
    aziMat = reshape(scaledAzi,[320 240]); eleMat = reshape(scaledEle,[320 240]);
    for j=1:c
        for k=1:r       
            newim(eleMat(j,k),aziMat(j,k),:) = im(k,j,:);    
        end
    end
    imshow(uint8(newim))
    drawnow
    hold on
end

end

