clear; clc;
clear; clc;close all;
Inputimage=imread('cameraman.tif');
SSIM=[];
QualityFactor=10:10:100
[r c p]=size(Inputimage);
figure;
for i=1:length(QualityFactor)
   imwrite(Inputimage,'Compressed.jpg','jpg','quality',QualityFactor(i));
   ReconstrcutedImage=imread('Compressed.jpg');
    SSIM(i)=ssim(Inputimage,ReconstrcutedImage);
   subplot(2,5,i);imshow(ReconstrcutedImage);
end
figure;
plot(QualityFactor,SSIM,'r-o');
xlabel('Quality Factor');
ylabel('SSIM');

figure;
Inputimage=imread('cameraman.tif');
MSSIM=[];
QualityFactor=10:10:100
[r c p]=size(Inputimage);
figure;
for i=1:length(QualityFactor)
   imwrite(Inputimage,'Compressed.jpg','jpg','quality',QualityFactor(i));
   ReconstrcutedImage=imread('Compressed.jpg');
    MSSIM(i)=multissim(Inputimage,ReconstrcutedImage);
   subplot(2,5,i);imshow(ReconstrcutedImage);
end
figure;
plot(QualityFactor,MSSIM,'r-o');
xlabel('Quality Factor');
ylabel('MSSIM');