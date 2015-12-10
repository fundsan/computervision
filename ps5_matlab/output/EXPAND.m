function newImg = EXPAND(img)
[y,x] = size(img);
a= .4;
a1 = 1/4;
a2 = a1 - (a/2);
sepFil =  [1/8 1/2 3/4 1/2 1/8];


oddConv= conv2(sepFil,sepFil');




newImg = zeros(y*2, x*2);
newImg(1:2:end,1:2:end) = img;
newImg = imfilter(newImg, oddConv);


