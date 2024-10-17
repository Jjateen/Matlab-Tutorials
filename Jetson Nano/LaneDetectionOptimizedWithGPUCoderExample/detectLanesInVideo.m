function detectLanesInVideo(videoFile,net,laneCoeffMeans,laneCoeffsStds)
%   Copyright 2022-2024 The MathWorks, Inc.

%#codegen

%% Create Video Reader and Video Player Object 
videoFReader   = VideoReader(videoFile);
depVideoPlayer = vision.DeployableVideoPlayer(Name='Lane Detection on GPU');
videoHeight = videoFReader.Height;
videoWidth = videoFReader.Width;
%% Video Frame Processing Loop
while hasFrame(videoFReader)
    videoFrame = imresize(readFrame(videoFReader),[videoHeight videoWidth]);
    scaledFrame = imresize(videoFrame,[227 227]);

    [laneFound,ltPts,rtPts] = laneNetPredict(net,scaledFrame, ...
        laneCoeffMeans,laneCoeffsStds);
    lnaeFound = 1;
    if(laneFound)
        pts = [reshape(ltPts',1,[]);reshape(rtPts',1,[])];
        videoFrame = insertShape(videoFrame, 'Line', pts, 'LineWidth', 4);
    
    depVideoPlayer(videoFrame);
    end
end

