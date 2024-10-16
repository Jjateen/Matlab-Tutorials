clc;
clear;
imds = imageDatastore('dataset','IncludeSubFolders',true,...
    'LabelSource','foldernames');
[Traindata,Testdata] = splitEachLabel(imds,0.8);
layers=[imageInputLayer([128 128 3])
        convolution2dLayer(5,10)
        reluLayer
        maxPooling2dLayer(2, 'Stride', 2)
        fullyConnectedLayer(2);
        softmaxLayer
        classificationLayer];
   
 options = trainingOptions('sgdm', ...
            'Plots', 'training-progress', ...
            'LearnRateSchedule', 'piecewise', ...
            'LearnRateDropFactor', 0.2, ...
            'LearnRateDropPeriod', 5, ...
            'MiniBatchSize', 300);
options.InitialLearnRate=0.0001;
options.MaxEpochs=30;

[net,info] = trainNetwork(Traindata, layers, options);

save net net
helpdlg('Training Process Completed');
[labels,err_test] = classify(net, Testdata, 'MiniBatchSize', 300);
confusionchart(Testdata.Labels,labels);
figure;
plotconfusion(Testdata.Labels,labels)
