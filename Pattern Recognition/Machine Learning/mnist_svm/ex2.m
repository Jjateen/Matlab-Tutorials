clc;
clear;
load Classifier;
[filename, pathname] = uigetfile('*.*', 'Pick an Image');
filename=strcat(pathname,filename);
img=imread(filename);
[Features] = extractHOGFeatures(img,'CellSize',[8 8]);
PredictedClass=predict(Classifier,Features);
PredictedClass=char(PredictedClass);
figure;imshow(img),title(PredictedClass);
disp(PredictedClass);

