clc;clear;
a=imread('cameraman.tif');
J = imnoise(a,'salt & pepper', 0.12);
Gaussian = imnoise(a,'gaussian',0,0.005);
GaussSalt = imnoise(J,'gaussian',0,0.005);
figure;
subplot(2,2,1);imshow(a);
subplot(2,2,2);imshow(J);
subplot(2,2,3);imshow(Gaussian);
subplot(2,2,4);imshow(GaussSalt);
Medfilt=medfilt2(GaussSalt,[5 5]);
Weiner=wiener2(Medfilt,[5 5]);
figure;imshow(Weiner);

