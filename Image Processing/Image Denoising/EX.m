clc;
a=imread('Noisy.png');
R=a(:,:,1);
G=a(:,:,2);
B=a(:,:,3);
R=medfilt2(R,[5 5]);
G=medfilt2(G,[5 5]);
B=medfilt2(B,[5 5]);
FilteredImage(:,:,1)=R;
FilteredImage(:,:,2)=G;
FilteredImage(:,:,3)=B;
figure;imshow(FilteredImage);


