% clear;
% a = arduino('com5','uno');
while (1)
  	voltage = readVoltage(a, 'A0');
  	tempC = voltage*100;
  	tempC=round(tempC);
  	if (tempC > 15)
    		disp(tempC)
  	end
  	pause(0.1);
end
