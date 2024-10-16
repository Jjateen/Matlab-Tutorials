clear;
close all;
referenceImage=imread('target.jpg');

figure(1)
imshow(referenceImage);

referenceImageGray = rgb2gray(referenceImage);
figure(2)
imshow(referenceImageGray);

referencePts=detectSURFFeatures(referenceImageGray);
referenceFeatures=extractFeatures(referenceImageGray,referencePts);
figure;
imshow(referenceImage), hold on;
plot(referencePts.selectStrongest(50));

video=  vision.VideoFileReader('1.mp4','VideoOutputDataType','uint8');

for k=1:30
    step(video);
end
camera=webcam(2);
set(camera, 'Resolution', '640x480');
cameraFrame=snapshot(camera); 

cameraFrameGray=rgb2gray(cameraFrame);
cameraPts=detectSURFFeatures(cameraFrameGray);
 figure(1)
 imshow(cameraFrame), hold on;
 plot(cameraPts.selectStrongest(50));

cameraFeatures=extractFeatures(cameraFrameGray,cameraPts);
idxPairs=matchFeatures(cameraFeatures,referenceFeatures);
matchedCameraPts=cameraPts(idxPairs(:,1));
matchedReferencePts=referencePts(idxPairs(:,2));
figure(1)
showMatchedFeatures(cameraFrame,referenceImage,matchedCameraPts,matchedReferencePts,'Montage' );

[referenceTransform,inlierReferencePts,inlierCameraPts]=estimateGeometricTransform(matchedReferencePts,matchedCameraPts, 'Similarity');
figure(1)
showMatchedFeatures(cameraFrame,referenceImage,...
inlierCameraPts,inlierReferencePts,'Montage');
videoFrame=step(video);
repDims=size(videoFrame(:,:,1));
refDims=size(referenceImage);
scaleTransform=findScaleTransform(refDims,repDims);
outputView=imref2d(size(referenceImage));

videoFrameScaled=imwarp(video,scaleTransform,'outputView',outputView);
figure(1)
imshowpair(reference,videoFrameScaled,'Montage');


outputView=imref2d(size(cameraFrame));
videoFrameTransformed=imwarp(videoFrameScaled,referenceTransform,'output',outputView);
figure(1)
imshowpair(cameraFrame,videoframeTransformed,'Montage');

alphaBlender=vision.AlphaBlender('operation','binary mask','MaskSource','input port');


mask=videoFrameformed(:,:,1)|videoFrameTransformed(:,:,2)|videoFrameTransformed(:,:,3)>0;

outputFrame=step(alphaBlender,cameraFrame,videoFrameTransformed,mask);
figure(1)
imshow(outputFrame);

pointTracker=vision.pointTracker('MaxbidirectionError',2);
initialize(pointTracker,inlierCameraPts.Location,cameraFrame);

trackingMarkers=inserMarker(cameFrame,inliercameraPts.Location,'size',7,'color',yellow);
figure(1)
imshow(trackingMarkers);


prevCameraFrame=cameraFrame;
cameraFrame=snapshot(camera);

[trackedPoints,isValid]=step(pointTracker,cameraframe);

newValidLocation= trackedPoints(isValid,:);
oldValidLocation=inliercameraPts.Location(isValid,:);


                                    if(nnz(isValid>=2))
                                        [trackingGTransform,oldInlierLocation,newInlierLocation]=estimationGeometricTransform(oldValidLocation,newValidLocation,'similarity');
                                    end
                                    figure(1)
                                    showMatchedFeatures(prevCameraFrame,cameraFrame,oldInlierLocation,newInlierLocation,'Motage');

                                    setPoints(pointTracker,newValidLocation);


trackingtransform.t=referenceTransform.T*trackingTransform.T;
repFrame=step(video);

outputView=imref2d(size(referenceImage));
videoFrameScaled=imwarp(videoFrame,scaleTransform,'OutputView',outputView);

figure(1);

imshowpair(referenceImage,videoFrameScaled,'Montage');
outputView=imref2d(size(cameraFrame));
videoFrameTransformed=imwarp(videoFrameScaled,trackingTransform,'outputView',outputView);

figure(1)
imshowpair(cameraFrame,videoFrameTransformed,'Montage');

mask=videoFrameTransformed(:,:,1)|videoFrameTransformed(:,:,2)|videoFrameTransformed(:,:,3)>0;

outputFrame=step(alphaBlender,cameraFrame,videoFrametransformed,mask);
figure(1)
imshow(outputFrame);
release(video);
delete(camera);
