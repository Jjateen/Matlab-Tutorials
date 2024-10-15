clc;
clear;
close all;
a=imread('rose.png');
b=rgb2gray(a);
[r g b]=imsplit(a);
figure;imshow(r);
figure;imshow(b);

Red(:,:,1)=r;
Red(:,:,2)=0;
Red(:,:,3)=0;
figure;imshow(Red);
Green(:,:,2)=g;
Green(:,:,1)=0;
Green(:,:,3)=0;
figure;imshow(Green);
Blue(:,:,3)=b;
Blue(:,:,1)=0;
Blue(:,:,2)=0;
figure;imshow(Blue);