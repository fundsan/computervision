function newImg = REDUCE(img)
[oldY, oldX] = size(img);
a= .4;
a1 = 1/4;
a2 = a1 - (a/2);
sepFil =  [1/16  1/4  3/8  1/4  1/16];
convFil = conv2(sepFil, sepFil');
smoothed = imfilter(img, convFil);



newImg = smoothed(1:2:end,1:2:end);

    
    

        