% Construct a webcam object
clc;clear;close all;
camObj = webcam(3);
% Preview a stream of image frames.
preview(camObj);
% Acquire and display a single image frame.
img = snapshot(camObj);
imwrite(img,'target.bmp');
imshow(img);