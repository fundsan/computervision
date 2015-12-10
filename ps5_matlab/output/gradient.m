function [gx,gy] = gradient(img ) 

[gx, gy] = imgradientxy(img);
gx = (gx+4) ./ 8  ;

gy = (gy+4) ./ 8; 
gy = -gy;
end
