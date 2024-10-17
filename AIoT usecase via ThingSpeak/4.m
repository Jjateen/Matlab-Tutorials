clc;
clear;
P = 1:50;
load Tc;
T = ind2vec(Tc);
spread = 1;
nettemp = newpnn(P,T,spread);
setpref('Internet','SMTP_Server','smtp.gmail.com');
setpref('Internet','E_mail','thingspeak001@gmail.com'); %sender mail id 
setpref('Internet','SMTP_Username','thingspeak0001@gmail.com'); %sender mail id
setpref('Internet','SMTP_Password','Testing!'); %sender password
% The following is necessary only if you are using GMail
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.starttls.enable','true');
EmailID='jeevarajan.mk@pantechmail.com';

channelID=1161425;
readAPIKey = 'JW5HGV6UDD9DF0UX';
MQ2 = thingSpeakRead(channelID,'Fields',1,'ReadKey',readAPIKey);
temp = thingSpeakRead(channelID,'Fields',2,'ReadKey',readAPIKey);
ultrasonic = thingSpeakRead(channelID,'Fields',3,'ReadKey',readAPIKey);
disp(temp);

a = sim(nettemp,temp);
ac = vec2ind(a);
disp(ac);
if ac>= 2
    attachedFullFileName='temp.docx';
    sendmail(EmailID,'TEMPERATURE ALERT','Your Engine is Overheating:Please check the attachment' ,attachedFullFileName);
    pause(5);
    disp('Mail Sent');
else
    disp('Mail  not Sent'); 
end
