clear;
clc;
Inputimage=imread('cameraman.tif');
MSE=[];
QualityFactor=10:20:80
[r c]=size(Inputimage);
figure;
for i=1:length(QualityFactor)
   imwrite(Inputimage,'Compressed.jpg','jpg','quality',QualityFactor(i));
   ReconstrcutedImage=imread('Compressed.jpg');
   MSE(i)=sum(sum(Inputimage-ReconstrcutedImage).^2)/(r*c);
   subplot(2,2,i);imshow(ReconstrcutedImage);
end
figure;
plot(QualityFactor,MSE,'r-o');
xlabel('Quality Factor');
ylabel('MSE');

