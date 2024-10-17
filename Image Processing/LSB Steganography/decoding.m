clc;
clear;
target=imread('secret.bmp');
[r c p]=size(target);
lengthoftext=target(r,c,1);% Text Size
width=target(r,c,2);% Image's Width
i=1;j=1;k=1;
while k<=lengthoftext
    r1=target(i,j,1);
    r2=target(i,j,2);
    r3=target(i,j,3);

    R(k)=findtext(r1,r2,r3);

        if(i<width)
            i=i+1;
        else
            i=1;
            j=j+1;
        end
        k=k+1;
end

fid = fopen('secret.txt','wb');
fwrite(fid,char(R),'char');
fclose(fid);

 helpdlg('data Retrived succesfully in secret.txt');
