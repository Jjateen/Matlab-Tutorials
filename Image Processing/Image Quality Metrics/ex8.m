clc;
clear;
a=imread('cameraman.tif');
b = imnoise(a,'salt & pepper', 0.12);
c=medfilt2(b,[5 5]);
clc;
brisqueinput=niqe(a);
disp(brisqueinput);
brisquenoisy=niqe(b);
disp(brisquenoisy);
brisquefilteres=niqe(c);
disp(brisquefilteres);
fprintf('niqe score for original image is %0.4f.\n',brisqueinput);
fprintf('niqe score for noisy image is %0.4f.\n',brisquenoisy);
fprintf('niqe score for denoise image is %0.4f.\n',brisquefilteres);

figure;
subplot(1,3,1);imshow(a)
subplot(1,3,2);imshow(b)
subplot(1,3,3);imshow(c)
