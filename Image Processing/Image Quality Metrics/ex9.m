clc;
clear;
a=imread('cameraman.tif');
b = imnoise(a,'salt & pepper', 0.12);
c=medfilt2(b,[5 5]);
clc;
brisqueinput=piqe(a);
disp(brisqueinput);
brisquenoisy=piqe(b);
disp(brisquenoisy);
brisquefilteres=piqe(c);
disp(brisquefilteres);
fprintf('piqe score for original image is %0.4f.\n',brisqueinput);
fprintf('piqe score for noisy image is %0.4f.\n',brisquenoisy);
fprintf('piqe score for denoise image is %0.4f.\n',brisquefilteres);

figure;
subplot(1,3,1);imshow(a)
subplot(1,3,2);imshow(b)
subplot(1,3,3);imshow(c)
