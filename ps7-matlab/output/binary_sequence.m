function binaryImage = binary_sequence(img0,img1, threshhold)
    img0 = rgb2gray(img0);
    img1 = rgb2gray(img1);
    binaryImage = abs(double(img0)-double(img1)) > threshhold;
    