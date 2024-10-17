clear; clc;
Inputimage=imread('cameraman.tif');
PSNR=[];
QualityFactor=10:10:100
[r c p]=size(Inputimage);
figure;
for i=1:length(QualityFactor)
   imwrite(Inputimage,'Compressed.jpg','jpg','quality',QualityFactor(i));
   ReconstrcutedImage=imread('Compressed.jpg');
    PSNR(i)=psnr(Inputimage,ReconstrcutedImage);
   subplot(2,5,i);imshow(ReconstrcutedImage);
end
figure;
plot(QualityFactor,PSNR,'r-o');
xlabel('Quality Factor');
ylabel('psnr');