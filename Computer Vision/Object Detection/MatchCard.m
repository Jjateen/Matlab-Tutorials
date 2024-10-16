clear all; close all; clc;
%% Load reference image, and compute surf features
ref_img = imread('MWqueen_crop_small.bmp');
image = imread('MWsample_full.png');
I = rgb2gray(image);
ref_img_gray = rgb2gray(ref_img);
ref_pts = detectSURFFeatures(ref_img_gray);
I_pts = detectSURFFeatures(I);

[ref_features,  ref_validPts] = extractFeatures(ref_img_gray,  ref_pts);
[I_features, I_validPts] = extractFeatures(I, I_pts);

%% Compare card image to video frame
index_pairs = matchFeatures(ref_features, I_features);

ref_matched_pts = ref_validPts(index_pairs(:,1)).Location;
I_matched_pts = I_validPts(index_pairs(:,2)).Location;

figure, showMatchedFeatures(image, ref_img, I_matched_pts, ref_matched_pts, 'montage');
title('Showing all matches');



