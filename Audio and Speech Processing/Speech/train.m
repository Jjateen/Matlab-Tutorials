clc;
clear;

ads = audioDatastore('Dataset','IncludeSubfolders',true, ... 
    'FileExtensions','.flac', ... 
    'LabelSource','foldernames');

[adsTrain, adsTest] = splitEachLabel(ads,0.8);

trainDatastoreCount = countEachLabel(adsTrain)
[sampleTrain, dsInfo] = read(adsTrain);
sound(sampleTrain,dsInfo.SampleRate);
reset(adsTrain)
disp('stop');
fs = dsInfo.SampleRate;
windowLength = round(0.03*fs);
overlapLength = round(0.025*fs);

features = [];
labels = [];

while hasdata(adsTrain)
    [audioIn,dsInfo] = read(adsTrain);

    melC = mfcc(audioIn,fs,'WindowLength',windowLength,'OverlapLength',overlapLength);
    
    f0 = pitch(audioIn,fs,'WindowLength',windowLength,'OverlapLength',overlapLength);
    
    feat = [melC,f0];
    
    voicedSpeech = isVoicedSpeech(audioIn,fs,windowLength,overlapLength);
    feat(~voicedSpeech,:) = [];
    
    label = repelem(dsInfo.Label,size(feat,1));
    
    features = [features;feat];
    
    labels = [labels,label];
end

M = mean(features,1);
S = std(features,[],1);
features = (features-M)./S;


trainedClassifier = fitcknn( ...
   			 features, ...
    			labels, ...
    			'Distance','euclidean', ...
    			'NumNeighbors',5, ...
    			'DistanceWeight','squaredinverse', ...
    			'Standardize',false, ...
    			'ClassNames',unique(labels));
            
            
            k = 5;
group = labels;
c = cvpartition(group,'KFold',k); % 5-fold stratified cross validation
partitionedModel = crossval(trainedClassifier,'CVPartition',c);
validationAccuracy = 1 - kfoldLoss(partitionedModel,'LossFun','ClassifError');
fprintf('\nValidation accuracy = %.2f%%\n', validationAccuracy*100);
validationPredictions = kfoldPredict(partitionedModel);
figure
cm = confusionchart(labels,validationPredictions,'title','Validation Accuracy');
cm.ColumnSummary = 'column-normalized';
cm.RowSummary = 'row-normalized';


features = [];
labels = [];
numVectorsPerFile = [];
while hasdata(adsTest)
       [audioIn,dsInfo] = read(adsTest);
        melC = mfcc(audioIn,fs,'WindowLength',windowLength,'OverlapLength',overlapLength);
       f0 = pitch(audioIn,fs,'WindowLength',windowLength,'OverlapLength',overlapLength);
       feat = [melC,f0];
       voicedSpeech = isVoicedSpeech(audioIn,fs,windowLength,overlapLength);
       feat(~voicedSpeech,:) = [];
       numVec = size(feat,1);
       label = repelem(dsInfo.Label,numVec);
       numVectorsPerFile = [numVectorsPerFile,numVec];
       features = [features;feat];
       labels = [labels,label];
end
features = (features-M)./S;
prediction = predict(trainedClassifier,features);
prediction = categorical(string(prediction));
figure('Units','normalized','Position',[0.4 0.4 0.4 0.4])
cm = confusionchart(labels,prediction,'title','Test Accuracy (Per Frame)');
cm.ColumnSummary = 'column-normalized';
cm.RowSummary = 'row-normalized';


disp('stop');
    