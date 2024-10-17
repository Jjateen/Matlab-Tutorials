clear;clc;
r = audiorecorder(22050, 16, 1);
record(r);     % speak into microphone...
pause(r);
p = play(r);   % listen
resume(r);     % speak again
stop(r);
p = play(r);   % listen to complete recording
mySpeech = getaudiodata(r, 'int16'); % get data as int16 array
audiowrite('test2.wav',mySpeech,22050);
