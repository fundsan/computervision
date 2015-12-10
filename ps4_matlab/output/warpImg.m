function newImg = warpImg(aff, img)
[sizeY, sizeX] = size(img);
newImg = zeros(size(img)+600);

for x = 1:sizeX
    for y = 1:sizeY
        values = [x,y, 1];
        point = int16(values*aff');
        
        newImg(300+ point(1,2),point(1,1)+300) = img(y,x);
    end
end