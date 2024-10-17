 text=65;
red=2;
green=17
blue=10
[mred,mgreen,mblue] = hidetext(red,green,blue,text);
[hiddentext] = findtext(mred,mgreen,mblue)
hiddentext=0;
disp(mred);
disp(mgreen);
disp(mblue);
