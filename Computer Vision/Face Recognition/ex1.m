clear;clc;
%Initialize Face detector
faceDetector = vision.CascadeObjectDetector; % Default: finds faces 
%Initilaize webcam
camObj = webcam(2);
count=1;
while(1)
img = snapshot(camObj);
bboxes = step(faceDetector, img); % Detect faces

if ~isempty (bboxes)
% Face detection
    if count==20
        break
    else
    % draw the bounding box on the frame
    Face=imcrop(img,bboxes(1,:));
    Face=imresize(Face,[128 128]);
    filename=strcat(num2str(count),'.bmp');
    imwrite(Face,filename);
    IFaces = insertObjectAnnotation(img, 'rectangle', bboxes, 'Face');
    imshow(IFaces), title('Detected faces');
    count=count+1;
    end
end
end