function R = Harris(gx, gy, windowsize)
filter = fspecial('gaussian', [windowsize, windowsize], windowsize*1);
theOnes = ones([windowsize, windowsize]);
smoothed = imfilter(theOnes, filter);
gxsquared = gx.^2;
gysquared = gy.^2;
gxgy= gx.*gy;
R = zeros( size (gx));
[ysize, xsize] = size (gx);

gx2Sum = imfilter(gxsquared,smoothed,'symmetric'); 
gy2Sum = imfilter(gysquared,smoothed,'symmetric'); 
gxgySum = imfilter(gxgy,smoothed,'symmetric'); 


for v = 1: ysize
    for u = 1 : xsize
        M = [gx2Sum(v,u), gxgySum(v,u);
             gxgySum(v,u), gy2Sum(v,u)];
         
         a = .04;
         R(v,u) = det(M) - a * (trace(M).^2); 
    end
end
R = (R - min(R(:)))/(max(R(:)) - min(R(:)));


end

    
       