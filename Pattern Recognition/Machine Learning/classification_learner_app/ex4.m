load trainedClassifier
[filename, pathname] = uigetfile('*.*');
filename=strcat(pathname,filename);
img=imread(filename);
[feature] = extractHOGFeatures(img,'CellSize',[8 8]);
class=predict(trainedClassifier.ClassificationSVM,feature);
disp(class);


