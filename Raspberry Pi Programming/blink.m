clear;
clear rpi
rpi = raspi('169.254.150.39','jjpi','password'); 
disp(rpi);
for i=1:10
writeDigitalPin(rpi,21,1);
pause(1);
writeDigitalPin(rpi,21,0);
pause(1)
end
