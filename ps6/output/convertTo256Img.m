function newImg = convertTo256Img(img)
MAX = max(img(:));
MIN = min(img(:));
MIN = min(MIN,[0]);
newImg = uint8(floor(255 .*(img - MIN) ./ ( MAX - MIN) ));

