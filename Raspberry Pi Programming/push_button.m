clear rpi
rpi = raspi('169.254.150.39','jjpi','password'); 
for i = 1:100
    buttonPressed = readDigitalPin(rpi, 20);
    if (buttonPressed ==0)
        for j = 1:10
            writeDigitalPin(rpi, 21, 1);
            pause(0.05);
            writeDigitalPin(rpi, 21, 0);
            pause(0.05);
        end
    end
    pause(0.1);
end
