clc;
clear;
[Y, FS]=audioread('1.wav');
p = audioplayer(Y, FS);
play(p);
audiowrite('2.wav',Y,FS);
[Y, FS]=audioread('test2.wav');
p = audioplayer(Y, FS);
play(p);
