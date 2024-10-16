clc;clear;close all;
figure;
Qvalue=10;
InputImage=imread('cameraman.tif');
subplot(1,3,1);imshow(InputImage);
[Row col plane]=size(InputImage);
[LL LH HL HH]=dwt2(InputImage,'haar');
Dec=[LL,LH;HL,HH];
% figure;imshow(Dec,[]);
subplot(1,3,2);imshow(Dec,[]);

Dec=Dec/Qvalue;
Dec=round(Dec);
QuantizedImage=Dec;
ImageArray=toZigzag(QuantizedImage);
%%%
j=1;
a=length(ImageArray);
count=0;
for n=1:a
    b=ImageArray(n);
    if n==a
        count=count+1;
        c(j)=count;
        s(j)=ImageArray(n);
    elseif ImageArray(n)==ImageArray(n+1)
        count=count+1;
    elseif ImageArray(n)==b
        count=count+1;
        c(j)=count;
        s(j)=ImageArray(n);
        j=j+1;
        count=0;
    end
end

%%%
InputBitcost=Row*col*8;
InputBitcost=(InputBitcost);
c1=length(c);
s1=length(s);
OutputBitcost= (c1*8)+(s1*8);
OutputBitcost=(OutputBitcost);

%%%----
g=length(s);
j=1;
l=1;
for i=1:g
    v(l)=s(j);
    if c(j)~=0
        w=l+c(j)-1;
        for p=l:w
            v(l)=s(j);
            l=l+1;
        end
    end
    j=j+1;
end
 
ReconstructedImageArray=v;


%%%---
ReconstructedImage=invZigzag(ImageArray)


Dec=ReconstructedImage*Qvalue;

LLr=Dec(1:Row/2,1:Row/2);
LHr=Dec(1:Row/2,Row/2+1:Row);
HLr=Dec(Row/2+1:Row,1:Row/2);
HHr=Dec(Row/2+1:Row,Row/2+1:Row);

ReconstrucedImage=idwt2(LLr,LHr,HLr,HHr,'haar');
subplot(1,3,3);imshow(ReconstrucedImage,[]);

%% Calculating PSNR and MSE
InputImage=double(InputImage);
ReconstructedImage=double(ReconstrucedImage);
n=size(InputImage);
M=n(1);
N=n(2);
MSE = sum(sum((InputImage-ReconstructedImage).^2))/(M*N);
PSNR = 10*log10(256*256/MSE);
disp('MSE');
disp(MSE);
disp('PSNR');
disp(PSNR);
disp('InputBitcost');
disp(InputBitcost);
disp('OutputBitcost');
disp(OutputBitcost);
