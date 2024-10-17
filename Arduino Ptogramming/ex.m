time=200;
while time > 0
      voltage = readVoltage(a, 'A0');
      voltage=round(voltage);
      clc;
      disp(voltage);
      time = time - 1;
      pause(0.1);
end