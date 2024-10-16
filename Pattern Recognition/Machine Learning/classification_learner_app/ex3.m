clc;clear;
imds = imageDatastore('database','IncludeSubFolders',true,...
'LabelSource','foldernames');
                   % Read all of the images
trainingFeatures=[];
for i = 1:numel(imds.Files)         % Read images using a for loop
   img = readimage(imds,i);
   trainingFeatures(i,:) = extractHOGFeatures(img,'CellSize',[8 8]);

end
trainingFeatures=array2table(trainingFeatures);
trainingFeatures.Class=imds.Labels;

save trainingFeatures trainingFeatures;

