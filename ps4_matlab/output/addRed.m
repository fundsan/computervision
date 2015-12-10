function newImg = addRed(grayImg, dots)

[ysize, xsize] = size(grayImg);
dotM = uint8(zeros(ysize,xsize));
dotM(dots) = 255;
newImg = uint8(zeros(ysize,xsize,3));
newImg(:,:,1) = grayImg;
redImg = newImg(:,:,1);
redImg(dots) = 255;
newImg(:,:,1) = redImg;

newImg(:,:,2) = grayImg;

greenImg = newImg(:,:,2);
greenImg(dots) = 0;
newImg(:,:,2) = greenImg;

newImg(:,:,3) = grayImg;

blueImg = newImg(:,:,3);
blueImg(dots) = 0;
newImg(:,:,3) = blueImg;


