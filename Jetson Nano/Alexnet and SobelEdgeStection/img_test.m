net = alexnet()
net.Layers
% Read the image to classify 
I = imread('peppers.png');
% Crop image to the input size of the network 
sz = net.Layers(1).InputSize
I = I(1:sz(1), 1:sz(2), 1:sz(3));
% Classify the image using AlexNet label 
classify(net, I) 
% Show the image and classification result
figure; imshow(1)
text(10, 20, char(label), 'Color', 'white')