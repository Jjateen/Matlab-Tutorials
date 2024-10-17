clc;clear;
fid = fopen('mesage.txt','r')
F=fread(fid);
Message=char(F');
fclose(fid);
Len=length(F);

% M=str2num(M);
P=11;
Q=13;
e=7
N=143;
% %D=103;
% N=input('enter the value of N:'); % 
% e=input('enter the value of e:'); %public key
clc;
%Encryption
for i=1:Len
ciphertext(i) = encryption(F(i),N,e);
end
disp('Cipher');
disp(ciphertext);
fid=fopen('cipher.txt','wb');
fwrite(fid,ciphertext);
fclose(fid);



fid = fopen('cipher.txt','r')
ciphertext=fread(fid);
% Message=char(F');
fclose(fid);

d=103;
for i=1:Len
    Message(i) = decryption(ciphertext(i),N,d);
end

fid = fopen('decryptedmessage.txt','wb')
fwrite(fid,char(Message),'char');
fclose(fid);

