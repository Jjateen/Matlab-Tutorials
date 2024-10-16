l1=imread('cameraman.tif');
l2=imrotate(11,45);
% Detect SURF features. Other feature detectors can be used too.
points1 detectSURFFeatures(l1);
points2 = detectSURFFeatures(l2);
% Extract features from images
[f1, vpts1] = extractFeatures(l1, points1); %f1-features % Validpoints
[f2, vpts2] = extractFeatures(l2, points2);
% Match features between images
indexPairs matchFeatures(f1, f2);
matchedPoints1 = vpts1(indexPairs(:, 1));
matchedPoints2 = vpts2 (indexPairs(:, 2));
figure; showMatchedFeatures(l1, l2, matchedPoints1, matchedPoints2);
legend('matched points 1','matched points 2');