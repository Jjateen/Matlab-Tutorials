clc;
clear;
a=imread('cameraman.tif');
b = imnoise(a,'salt & pepper', 0.12);
c=medfilt2(b,[5 5]);
% c=medfilt2(c,[5 5]);
clc;
brisqueinput=brisque(a);
disp(brisqueinput);
brisquenoisy=brisque(b);
disp(brisquenoisy);
brisquefilteres=brisque(c);
disp(brisquefilteres);
fprintf('BRISQUE score for original image is %0.4f.\n',brisqueinput);
fprintf('BRISQUE score for noisy image is %0.4f.\n',brisquenoisy);
fprintf('BRISQUE score for denoise image is %0.4f.\n',brisquefilteres);

