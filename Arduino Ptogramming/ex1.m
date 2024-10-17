clear;
a=arduino();
for i=1:10
    writeDigitalPin(a,'D10',1);
    pause(1);
    writeDigitalPin(a,'D10',0);
    pause(1);
end
