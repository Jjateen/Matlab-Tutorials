clear;clc;
Inputimage=imread('cameraman.tif');
imwrite(Inputimage,'Compressed.jpg','jpg','quality',100);
ReconstrcutedImage=imread('Compressed.jpg');
figure;
subplot(1,2,1);imshow(Inputimage);
subplot(1,2,2);imshow(ReconstrcutedImage);
[r c p]=size(Inputimage);
mse=sum(sum(Inputimage-ReconstrcutedImage).^2)/(r*c);
PSNR=10*log10(255*255/mse);
disp(PSNR);
