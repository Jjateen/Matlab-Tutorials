 videoFReader = vision.VideoFileReader('1.mp4',...
     'VideoOutputDataType','uint8');
    videoPlayer = vision.VideoPlayer;
    while ~isDone(videoFReader)
      videoFrame = step(videoFReader);
      step(videoPlayer, videoFrame);
    end
    release(videoPlayer);
    release(videoFReader);