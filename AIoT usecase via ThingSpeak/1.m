clc;clear;
MQ2=input('Enter the Value for MQ2:');
Temp=input('Enter the Value for TEMP:');
Ultra=input('Enter the Value for ULTRASONIC:');
thingSpeakWrite(1161425,'Fields',[1,2,3],'Values',{MQ2,Temp,Ultra},'WriteKey','4GPW0Q6KLJ5M0UQB');
disp('exit');
