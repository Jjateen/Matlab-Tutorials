clc;
clear;
channelID=1161425;
readAPIKey = 'JW5HGV6UDD9DF0UX';
MQ2 = thingSpeakRead(channelID,'Fields',1,'ReadKey',readAPIKey);
temp = thingSpeakRead(channelID,'Fields',2,'ReadKey',readAPIKey);
ultrasonic = thingSpeakRead(channelID,'Fields',3,'ReadKey',readAPIKey);
disp(MQ2);
disp(temp);
disp(ultrasonic);