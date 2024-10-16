[labels,err_test] = classify(net, testingData, 'MiniBatchSize', 300);
confusionchart(testingData.Labels,labels);
figure;
plotconfusion(testingData.Labels,labels)
 
