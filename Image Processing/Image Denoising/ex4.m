clc;clear;
load colorflower
OriginalImage=colorflower.Orig;
NoisyImage=colorflower.Noisy;
FilterImage= wdenoise2(NoisyImage,2)
figure;
subplot(1,3,1);imshow(OriginalImage);
subplot(1,3,2);imshow(NoisyImage);
subplot(1,3,3);imshow(FilterImage);

