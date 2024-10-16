clc;clear;close all;
a=imread('crop.bmp');
b=imread('full.png');
a=rgb2gray(a);
b=rgb2gray(b);
Points1=detectSURFFeatures(a);
Points2=detectSURFFeatures(b);
f1=extractFeatures(a,Points1);
f2=extractFeatures(b,Points2);
indexPairs=matchFeatures(f1,f2);
Validpts1=Points1(indexPairs(:,1));
Validpts2=Points2(indexPairs(:,2));
showMatchedFeatures(a,b,Validpts1,Validpts2,'montage');


