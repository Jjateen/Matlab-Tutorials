function edgeDetection() %#codegen
% Create a connection to the Raspberry Pi hardware
  %r = raspi;
   rpi = raspi('169.254.150.39','jjpi','password');
% Create a connection to the Raspberry Pi camera module, capture live
% images, and then display the images
  w = webcam(rpi);
% Define convolutional kernel to be used for edge detection
  kern = [1 2 1; 0 0 0; -1 -2 -1];
% Run the edge detection algorithm on the images captured from the Raspberry Pi camera module.
  for k = 1:5000
  img = snapshot(w);
  h = conv2(img(:,:,2),kern,'same');
  v = conv2(img(:,:,2),kern','same');
  e = sqrt(h.*h + v.*v);
  edgeImg = uint8((e > 100) * 240);
  imshow(edgeImg);
%   displayImage(rpi,edgeImg,'Title','Edge Detection');
  end
End

%board = targetHardware('Raspberry Pi')
% deploy(board,'edgeDetection')
