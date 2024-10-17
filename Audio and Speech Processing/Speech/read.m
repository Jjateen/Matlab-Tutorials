clear;
[y Fs]=audioread('2.wav');
p = audioplayer(y, Fs);
play(p)
 

audiowrite('3.wav',y,Fs);
[y Fs]=audioread('2.wav');
p = audioplayer(y, Fs);
play(p)
