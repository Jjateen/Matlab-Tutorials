function sobelEdgeDetection() %#codegen
    hwobj = jetson('192.168.67.205', 'jetson', 'jetson');
    camlist = getCameraList(hwobj);
    camObj = camera (hwobj, "USB2.0 PC CAMERA", [640 480]);
    dispObj = imageDisplay(hwobj);
    % Sobel kernel
    kern = [1 2 1; 0 0 0; -1-2-1];
    % Main loop
    for k = 1:1000
        % Capture the image from the camera on hardware. 
        img = snapshot(cam0bj); 
        % Finding horizontal and vertical gradients. 
        h = conv2(img(:,:,2), kern, 'same');
        v = conv2(img(:,:,2), kern','same');
        % Finding magnitude of the gradients.
        e = sqrt(h.*h + v.*v);
        % Threshold the edges 
        edgelmg = uint8((e > 100) * 240); 
        % Display image. 
        imshow(edgelmg);
        end
end