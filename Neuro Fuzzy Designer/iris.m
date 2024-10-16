clc;clear;
load iris_dataset;
InputFeatures=irisInputs';

InputFeatures=array2table(InputFeatures);
irisTargets=vec2ind(irisTargets);
irisTargets=irisTargets';
InputFeatures.Class=irisTargets;