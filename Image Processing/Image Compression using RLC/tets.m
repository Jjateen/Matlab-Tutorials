clc;
clear;
a=[ 1 2 2 2 2  3 3 3 4 4 4 4];
[c,s] = runlengthencoding(a)

[ReconstructedImageArray] = runlengthdecoding(c,s)