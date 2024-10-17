clc;
clear;
Fs=8000; 
ch = 1;
datatype = 'uint8'
nbits = 16;
seconds = 5;
fprintf('say "This is a test message" after hitting enter'); 
input(''); 
recorder = audiorecorder(Fs,nbits,ch);
recordblocking(recorder,seconds);
disp('Recording Stoped');
x = getaudiodata(recorder,datatype);
ap = audioplayer(x,Fs);
playblocking(ap);
audiowrite('test.wav',x,Fs);
% [y Fs]=audioread('test.wav');
% p = audioplayer(y, Fs);
% play(p)
