clc;
clear;

load net
[filename, pathname] = uigetfile('*.*');
a=imread(strcat(pathname,filename));
Class=classify(net,a);
clc;
disp('Recognized Class');
disp(Class)

