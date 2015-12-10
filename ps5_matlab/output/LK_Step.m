function[U ,V] = LK_Step(gx, gy, gt, windowsize)

theOnes = ones([windowsize, windowsize])./(windowsize*windowsize);

gxsquared = gx.^2;
gysquared = gy.^2;
gxgy= gx.*gy;
gxgt = gx.*gt;
gygt = gy.*gt;
U = zeros( size (gx));
V = zeros( size (gy));
[ysize, xsize] = size (gx);

gx2Sum = imfilter(gxsquared,theOnes ,'symmetric'); 
gy2Sum = imfilter(gysquared,theOnes ,'symmetric'); 
gxgySum = imfilter(gxgy,theOnes ,'symmetric'); 
gxgtSum = imfilter(gxgt, theOnes ,'symmetric');
gygtSum = imfilter(gygt,theOnes ,'symmetric');

for y = 1: ysize
    for x = 1 : xsize
        M = [gx2Sum(y,x), gxgySum(y,x);
             gxgySum(y,x), gy2Sum(y,x)];
         R = -[gxgtSum(y,x);gygtSum(y,x)];
        
        [ A ,S, B] = svd(M);
        eigen = diag(S); 
        lambda1 = eigen(1);
        lambda2 = eigen(2);

            if lambda1 < 0.0000001 || lambda2 < 0.0000001 ||abs(log10(lambda1) -log10(lambda2)) > 1.5
                
                uv = [0,0];
                
            else
                invS = [1/lambda1 0; 0 1/lambda2];
                uv = A * invS *B' *R;
                
              
            end
        
        U(y,x) = uv(1);
        V(y,x) = uv(2);
    end
end