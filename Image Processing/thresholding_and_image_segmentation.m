a=imread('coins.png');
figure;
imshow(a);
figure;imhist(a);
b=a>100;
figure;
imshow(b);
c=medfilt2(b,[5 5]);
c=uint8(c);
d=c.*a;
figure;imshow(d);