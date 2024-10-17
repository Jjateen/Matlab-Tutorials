
load deepnet
[filename, pathname] = uigetfile('*.*', 'Pick a Image');
I = imread(strcat(pathname,filename));
I=imresize(I,[720 960]);
C = semanticseg(I, net);
B = labeloverlay(I,C,'Colormap',cmap,'Transparency',0.4);
figure;
imshow(I);
figure;
imshow(B)
pixelLabelColorbar(cmap, classes);