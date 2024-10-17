function edgeDetection()
rpi = raspi('169.254.150.39','jjpi','password');
w = webcam(rpi);
kern = [1 2 1; 
        0 0 0;
        -1 -2 -1];

for k = 1:1000
      img = snapshot(w);
      h = conv2(img(:,:,2),kern,'same');
      v = conv2(img(:,:,2),kern','same');
      e = sqrt(h.*h + v.*v);
      edgeImg = uint8((e > 100) * 240);
      image(edgeImg);
end
end