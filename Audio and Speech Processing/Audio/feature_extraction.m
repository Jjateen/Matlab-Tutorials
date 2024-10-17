clc;
clear;
[audioIn,fs] = audioread("Counting-16-44p1-mono-15secs.wav");
 aFE = audioFeatureExtractor('melSpectrum',true,'barkSpectrum',true, ...
           'erbSpectrum',true,'linearSpectrum',true,'SampleRate',44.1e3);
  
 features = extract(aFE,audioIn);
 features = (features - mean(features,1))./std(features,[],1);
 idx = info(aFE);
 duration = size(audioIn,1)/fs;
 subplot(2,1,1)
t = linspace(0,duration,size(audioIn,1));
plot(t,audioIn);
 subplot(2,1,2)
t = linspace(0,duration,size(features,1));
%  plot(t,features(:,idx.spectralCentroid), ...
%      t,features(:,idx.spectralKurtosis), ...
%      t,features(:,idx.pitch));
%  legend("Spectral Centroid","Spectral Kurtosis", "Pitch")
%  xlabel("Time (s)")

 plot(t,features(:,idx.linearSpectrum), ...
     t,features(:,idx.melSpectrum), ...
     t,features(:,idx.barkSpectrum));
%  legend("Spectral Centroid","Spectral Kurtosis", "Pitch")
 xlabel("Time (s)")

