clear;
clc
load net;
fs = 44.1e3; 
duration = 0.5;
N = duration*fs; 

aFE = audioFeatureExtractor("SampleRate",fs, ...
    "SpectralDescriptorInput","melSpectrum", ...
    "spectralCentroid",true, ... 
    "spectralSlope",true);
    

wNoiseTest = 2*rand([N,1]) - 1; 
 label=classify(net,extract(aFE,wNoiseTest)');
 disp(label);

% 
bNoiseTest = filter(1,[1,-0.999],wNoiseTest); bNoiseTest= bNoiseTest./max(abs(bNoiseTest),[],'all'); 
classify(net,extract(aFE,bNoiseTest)')
% 
 pNoiseTest = pinknoise(N); 
 classify(net,extract(aFE,pNoiseTest)')

