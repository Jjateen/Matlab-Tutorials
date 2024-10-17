% clear;
% a=arduino();   
 configurePin(a, 'D2', 'pullup');
   while (1)
          data= readDigitalPin(a, 'D2');
          if data== 0
          writeDigitalPin(a,'D10',1);
          else
          % Change duration to zero to mute the speaker
           writeDigitalPin(a,'D10',0);
      end
      pause(0.1);
   end
