clc;clear;
imds = imageDatastore('dataset','IncludeSubFolders',true,...
    'LabelSource','foldernames');
disp(imds);
[traininData,testingData]=splitEachLabel(imds,0.90);
layers = [imageInputLayer([128 128 3])
                convolution2dLayer(5,20)
                reluLayer
                maxPooling2dLayer(2,'Stride',2)
                fullyConnectedLayer(2)
                softmaxLayer
                classificationLayer()]; 
            
            
 options = trainingOptions('sgdm', ...
            'Plots', 'training-progress', ...
            'LearnRateSchedule', 'piecewise', ...
            'LearnRateDropFactor', 0.2, ...
            'LearnRateDropPeriod', 5, ...
            'MiniBatchSize', 300);
options.MaxEpochs = 30; 
options.InitialLearnRate=0.0001;
[net,info] = trainNetwork(traininData,layers,options);

save net net;

     
     