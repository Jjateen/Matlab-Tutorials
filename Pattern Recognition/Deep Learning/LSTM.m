clc;
clear;
load HumanActivityTrain
numFeatures = 3;
numHiddenUnits = 200;
numClasses = 5;

layers = [ ...
    sequenceInputLayer(numFeatures)
    lstmLayer(numHiddenUnits,'OutputMode','sequence')
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];

options = trainingOptions('adam', ...
    'MaxEpochs',60, ...
    'GradientThreshold',2, ...
    'Verbose',0, ...
    'Plots','training-progress');

net = trainNetwork(XTrain,YTrain,layers,options);


 load HumanActivityTest
YPred = classify(net,XTrain{1});
acc = sum(YPred == YTrain{1})./numel(YTrain{1})
figure
plot(YPred,'.-')
hold on
plot(YTest{1})
hold off
xlabel("Time Step")
ylabel("Activity")
title("Predicted Activities")
legend(["Predicted" "Test Data"])

save net net;
