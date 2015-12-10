function newImg = convertTo256Img(img)
MAX = max(img(:));
MIN = min(img(:));
newImg = uint8(floor(255 .*(img - MIN) ./ ( MAX - MIN) ));

