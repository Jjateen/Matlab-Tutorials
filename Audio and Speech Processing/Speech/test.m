trainDatastoreCount = countEachLabel(adsTrain)
[sampleTrain, dsInfo] = read(adsTrain);
sound(sampleTrain,dsInfo.SampleRate);
reset(adsTrain)
disp('stop');
fs = dsInfo.SampleRate;
windowLength = round(0.03*fs);
overlapLength = round(0.025*fs);