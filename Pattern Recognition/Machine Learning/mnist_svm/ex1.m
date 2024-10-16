clc;clear;
imds = imageDatastore('database','IncludeSubFolders',true,...
           'LabelSource','foldernames');
trainingFeatures=[];
trainingLabels=imds.Labels;       
for i = 1:numel(imds.Files)         % Read images using a for loop
    img = readimage(imds,i);
    trainingFeatures(i,:) = extractHOGFeatures(img,'CellSize',[8 8]);
  
end
Classifier =fitcecoc(trainingFeatures,trainingLabels);
save Classifier Classifier

disp('Stop');