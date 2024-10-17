clc;clear;
original=imread('ROSE.PNG');
target=original;
fid = fopen('message.txt','r');
F = fread(fid);
s = char(F');
fclose(fid);

[r c p]=size(original);
lengthoftext=length(F);

i=1;j=1;k=1;
while k<=lengthoftext
        a=F(k);
        o1=original(i,j,1);
        o2=original(i,j,2);
        o3=original(i,j,3);
        [r1,r2,r3]=hidetext(o1,o2,o3,a); 
        target(i,j,1)=r1;
        target(i,j,2)=r2;
        target(i,j,3)=r3;
        if(i<r)
            i=i+1;
        else
            i=1;
            j=j+1;
        end
        k=k+1;
end
target(r,c,1)=lengthoftext;% Text Size
target(r,c,2)=r;% Image's Width
%save ;
imwrite(target,'secret.bmp','bmp');
figure;
imshow(target);title('Stego Image');
    
