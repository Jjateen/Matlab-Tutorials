
clear;
close all
camObj = webcam(2);
% preview(camObj);
 video = vision.VideoFileReader('1.mp4',...
     'VideoOutputDataType','uint8');
 for k=1:30
     step(video);
 end
boxImage = imread('target.jpg');
boxImage=rgb2gray(boxImage);
% figure;
% imshow(boxImage);
% title('Image of a Box');

while(1)

sceneImage1 = snapshot(camObj);

sceneImage=rgb2gray(sceneImage1);

boxPoints = detectSURFFeatures(boxImage);
scenePoints = detectSURFFeatures(sceneImage);

[boxFeatures, boxPoints] = extractFeatures(boxImage, boxPoints);
[sceneFeatures, scenePoints] = extractFeatures(sceneImage, scenePoints);

boxPairs = matchFeatures(boxFeatures, sceneFeatures);

matchedBoxPoints = boxPoints(boxPairs(:, 1), :);
matchedScenePoints = scenePoints(boxPairs(:, 2), :);
% showMatchedFeatures(boxImage, sceneImage, matchedBoxPoints, ...
%     matchedScenePoints, 'montage');
len=length(matchedScenePoints);
if len >20
        [referenceTransform, inlierBoxPoints, inlierScenePoints] = ...
            estimateGeometricTransform(matchedBoxPoints, matchedScenePoints, 'affine');

        
                    videoFrame = step(video);
        repDims=size(videoFrame(:,:,1));
        refDims=size(boxImage);
        [rr cc]=size(boxImage);
        videoFrameScaled=imresize(videoFrame,[rr cc]);
        scaleTransform = findScaleTransform(refDims,repDims);
        outputView = imref2d(size(boxImage));
     %   videoFrameScaled = imwarp(videoFrame, scaleTransform, 'OutputView', outputView);
       
        outputView = imref2d(size(sceneImage));
        videoFrameTransformed = imwarp(videoFrameScaled, referenceTransform, 'OutputView', outputView);

%         figure(1)
%         imshowpair(boxImage, videoFrameScaled, 'Montage');
        
        alphaBlender = vision.AlphaBlender('Operation', 'Binary mask', 'MaskSource', 'Input port');
        
        mask=videoFrameTransformed(:,:,1)|...
            videoFrameTransformed(:,:,2)|...
            videoFrameTransformed(:,:,3)>0;
        outputFrame=step(alphaBlender,videoFrame,videoFrameTransformed,mask);
        %figure;
       % imshow(outputFrame);
        % showMatchedFeatures(boxImage, sceneImage, inlierBoxPoints, ...
        %     inlierScenePoints, 'montage');
        % title('Matched Points (Inliers Only)');
        pointTracker = vision.PointTracker('MaxBidirectionalError',2);

       initialize(pointTracker,inlierScenePoints.Location,sceneImage);
trackingMarkers=insertMarker(sceneImage,inlierScenePoints.Location,...
    'Size',7,'color','yellow');
% figure(1);
% imshow(trackingMarkers);
prevCameraFrame=sceneImage;
sceneImage = snapshot(camObj);
sceneImage=rgb2gray(sceneImage);
[trackedPoints,isValid]=step(pointTracker,sceneImage);
newValidLocations=trackedPoints(isValid,:);
oldValidLocations=inlierScenePoints.Location(isValid,:);

if (nnz(isValid)>=2)
    [trackingTransform,oldInlinerLocations,newInlinerLocations]=...
                    estimateGeometricTransform(oldValidLocations, newValidLocations, 'Similarity');
end
setPoints(pointTracker,newValidLocations);
trackingTransform.T=referenceTransform.T*trackingTransform.T;
repFrame=step(video);

outputView=imref2d(size(boxImage));
videoFrameScaled=imwarp(videoFrame,scaleTransform,...
    'OutputView',outputView);

outputView=imref2d(size(sceneImage));
        videoFrameTransformed = imwarp(videoFrameScaled, referenceTransform, 'OutputView', outputView);

 mask=videoFrameTransformed(:,:,1)|...
            videoFrameTransformed(:,:,2)|...
            videoFrameTransformed(:,:,3)>0;
        outputFrame=step(alphaBlender,videoFrame,videoFrameTransformed,mask);
%         figure;
%         imshow(outputFrame);
%         

        boxPolygon = [1, 1;...                           % top-left
                size(boxImage, 2), 1;...                 % top-right
                size(boxImage, 2), size(boxImage, 1);... % bottom-right
                1, size(boxImage, 1);...                 % bottom-left
                1, 1];                   % top-left again to close the polygon

        newBoxPolygon = transformPointsForward(referenceTransform, boxPolygon);


        
       % imshow(sceneImage1);
        
        
        d='Object Recognized'
        currFrame=outputFrame;
        position = [321 430];    
        box_color = {'yellow'};
        RGB = insertText(currFrame,position,d,'FontSize',22,'BoxColor', box_color,'BoxOpacity',0.9);
             imshow(RGB);
            hold on;
        line(newBoxPolygon(:, 1), newBoxPolygon(:, 2), 'Color', 'y');
        title('Detected Box');
        
else
        d='Object Not Recognized'
        currFrame=sceneImage1;
        position = [321 430];    
        box_color = {'red'};
        RGB = insertText(currFrame,position,d,'FontSize',22,'BoxColor', box_color,'BoxOpacity',0.9);
     
        imshow(RGB);

end
end

