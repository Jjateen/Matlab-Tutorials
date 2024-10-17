time=500;
while time > 0
      voltage = readVoltage(a, 'A0');
%     voltage=round(voltage);
      writePWMVoltage(a, 'D11', voltage);
      clc;
      disp(voltage);
      time = time - 1;
      pause(0.1);
end