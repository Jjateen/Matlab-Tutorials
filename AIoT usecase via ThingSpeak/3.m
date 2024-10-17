clc;
clear;
temp=10
P = 1:50;
load Tc;
T = ind2vec(Tc);
spread = 1;
nettemp = newpnn(P,T,spread);
a = sim(nettemp,temp);
ac = vec2ind(a);
disp(ac);
if ac>= 2
	disp('Mail Sent');
 
end
