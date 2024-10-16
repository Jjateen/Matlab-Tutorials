
clear;
close all

referenceImage = imread('target.jpg');
referenceImageGray=rgb2gray(referenceImage);
figure;
imshow(referenceImageGray);
referencePts = detectSURFFeatures(referenceImageGray);
referenceFeatures = extractFeatures(referenceImageGray, referencePts);

video = vision.VideoFileReader('1.mp4',...
     'VideoOutputDataType','uint8');
 for k=1:30
     step(video);
 end

camera = webcam(2);
set(camera,'Resolution','640x480');
cameraFrame=snapshot(camera);
cameraFrameGray=rgb2gray(cameraFrame);
figure;
imshow(cameraFrameGray);
cameraPts = detectSURFFeatures(cameraFrameGray);
cameraFeatures = extractFeatures(cameraFrameGray, cameraPts);
idxPairs = matchFeatures(cameraFeatures,referenceFeatures);
matchedCameraPts = cameraPts(idxPairs(:,1));
matchedReferencePts = referencePts(idxPairs(:,2));

     [referenceTransform, inlierReferencePts, inlierCameraPts] = ...
            estimateGeometricTransform(matchedReferencePts, matchedCameraPts, 'Similarity');

                    videoFrame = step(video);
                    
        repDims=size(videoFrame(:,:,1));
        refDims=size(referenceImage);
%          [rr cc pp]=size(referenceImage);
%         videoFrame=imresize(videoFrame,[rr cc]);
        

Tinv  = referenceTransform.invert.T;

ss = Tinv(2,1);
sc = Tinv(1,1);
scaleRecovered = sqrt(ss*ss + sc*sc)
thetaRecovered = atan2(ss,sc)*180/pi
        scaleTransform = findScaleTransformn(refDims,repDims);


outputView = imref2d(size(referenceImage));
videoFrameScaled  = imwarp(videoFrame,scaleTransform,'OutputView',outputView);

%%
% scaleTransform = findScaleTransform(refDims,repDims);
%         outputView = imref2d(size(referenceImage));
%       videoFrameScaled = imwarp(videoFrame, scaleTransform, ...
%           'OutputView', outputView);
%        figure(1);
       imshowpair(referenceImage,videoFrameScaled,'Montage');
        
       
       outputView = imref2d(size(cameraFrame));
        videoFrameTransformed = imwarp(videoFrameScaled, referenceTransform, 'OutputView', outputView);

        figure(1)
        imshowpair(cameraFrame, videoFrameTransformed, 'Montage');
        
        
   alphaBlender = vision.AlphaBlender('Operation', 'Binary mask', 'MaskSource', 'Input port');
        
        mask=videoFrameTransformed(:,:,1)|...
            videoFrameTransformed(:,:,2)|...
            videoFrameTransformed(:,:,3)>0;
        outputFrame=step(alphaBlender,cameraFrame,videoFrameTransformed,mask);
     figure(1)
     imshow(outputFrame);
        pointTracker = vision.PointTracker('MaxBidirectionalError',2);

       initialize(pointTracker,inlierCameraPts.Location,cameraFrame);
trackingMarkers=insertMarker(cameraFrame,inlierCameraPts.Location,...
    'Size',7,'color','yellow');

figure(1);
imshow(trackingMarkers);
prevCameraFrame=cameraFrame;


cameraFrame = snapshot(camera);
[trackedPoints,isValid]=step(pointTracker,cameraFrame);

% cameraFrame=rgb2gray(cameraFrame);
newValidLocations=trackedPoints(isValid,:);
oldValidLocations=inlierCameraPts.Location(isValid,:);

if (nnz(isValid)>=2)
    [trackingTransform,oldInlinerLocations,newInlinerLocations]=...
                    estimateGeometricTransform(...
                    oldValidLocations, newValidLocations, 'Similarity');
end

setPoints(pointTracker,newValidLocations);
trackingTransform.T=referenceTransform.T*trackingTransform.T;
repFrame=step(video);

outputView=imref2d(size(referenceImage));
videoFrameScaled=imwarp(videoFrame,scaleTransform,...
    'OutputView',outputView);

figure(1);
imshowpair(referenceImage,videoFrameScaled,'Montage');
outputView=imref2d(size(cameraFrame));
        videoFrameTransformed = imwarp(videoFrameScaled, referenceTransform, 'OutputView', outputView);

 mask=videoFrameTransformed(:,:,1)|...
            videoFrameTransformed(:,:,2)|...
            videoFrameTransformed(:,:,3)>0;
        outputFrame=step(alphaBlender,cameraFrame,videoFrameTransformed,mask);
        figure;
        imshow(outputFrame);
        release(video);
        delete(camera);


        
