clc;
AFR = dsp.AudioFileReader('2.wav');
ADW = audioDeviceWriter(AFR.SampleRate);
 while ~isDone(AFR)
         audio = AFR();
         ADW(audio);
 end
 release(AFR);  % close the input file
 release(ADW);  % close the audio output device
