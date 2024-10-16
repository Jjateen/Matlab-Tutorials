function [matchedBoxPoints,matchedScenePoints] = featureextraction(boxImage,sceneImage)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
a=rgb2gray(boxImage);
b=rgb2gray(sceneImage);
Points1=detectSURFFeatures(a);
Points2=detectSURFFeatures(b);
f1=extractFeatures(a,Points1);
f2=extractFeatures(b,Points2);
indexPairs=matchFeatures(f1,f2);
matchedBoxPoints=Points1(indexPairs(:,1));
matchedScenePoints=Points2(indexPairs(:,2));


end

