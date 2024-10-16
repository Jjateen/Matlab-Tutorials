vidObj = VideoReader('1.mp4');
         vidObj.CurrentTime = 0.5;
numframes=vidObj.NumFrames;
      
       
        % Read video frames until available
        while hasFrame(vidObj)
            vidFrame = readFrame(vidObj);
            imshow(vidFrame);
                  % pause(1/vidObj.FrameRate);
     
        end
 
      