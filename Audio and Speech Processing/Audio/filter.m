clc;
clear;
close all;
f=0.8 % cut off frequecy
n=6; % n the order
a=fir1(n,f,'high');
b=fir1(n,f,'low');
 [y fs]=audioread('1.wav');
hp=filter(a,1,y);% pass to high pass
lp=filter(b,1,hp); % pass to low pass
 subplot(1,2,1);plot(y);title('input');
subplot(1,2,2);plot(real(lp));
