function newImg = trimImg(img, yTrim, xTrim)

[y , x] = size(img);

newImg = img(1:(y-yTrim), 1:(x-xTrim));
