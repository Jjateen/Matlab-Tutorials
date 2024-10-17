clc;clear;
a=imread('rose.png');
R=a(:,:,1);
G=a(:,:,2);
B=a(:,:,3);
R = imnoise(R,'salt & pepper', 0.12);
G = imnoise(G,'salt & pepper', 0.12);
B = imnoise(B,'salt & pepper', 0.12);
NoisyImage(:,:,1)=R;
NoisyImage(:,:,2)=G;
NoisyImage(:,:,3)=B;
imwrite(NoisyImage,'noisy.png');
figure;imshow(NoisyImage);

