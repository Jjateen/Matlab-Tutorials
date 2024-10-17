clear cam
clear rpi
rpi = raspi('169.254.150.39','jjpi','password');
cam = webcam(rpi);
for i = 1:100
    motionDetected = readDigitalPin(rpi, 16);
    if (motionDetected==0);
       fprintf('Motion detected on %s\n', datestr(now));
       for i = 1:3
           % Clear image buffer
           snapshot(cam);
       end
       img = snapshot(cam);
       image(img);
       drawnow;
       imwrite(img, 'motiondetected.jpg');
       % Wait until the motion detector output goes low
       pause(5);
    end
    pause(0.5);
end
