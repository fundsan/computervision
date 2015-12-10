function [U,V] = Heir_LK(L,R, layers)
    n = layers;
 
   [imgY, imgX] = size(R);
   reducesR = zeros(imgY, imgX, layers+1);
   reducesR(:,:,1) = R ;
   
   reducesL = zeros(imgY, imgX, layers+1);
   reducesL(:,:,1) = L ;
   siz = zeros(layers+1,2);
   siz(1,:) = [imgY,imgX];
   reduceR= R;
   reduceL = L;
   for s = 1:n
      reduceR = REDUCE(reduceR);
      reduceL = REDUCE(reduceL); 
      
      [rY,rX] = size(reduceR);
      siz(s+1,:) =size(reduceR);
      
      
      reducesL(1:rY,1:rX,s+1) = reduceL;
      reducesR(1:rY,1:rX,s+1) = reduceR;
      
   end
   
   U = zeros(rY,rX);
   V = zeros(rY, rX);
   gt = double(reduceR )- double(reduceL); 
[gx, gy ] = gradient(reduceL);
window = floor(rX/8);

if mod(window,2) ==0
    window = window+1;
end
   [u, v] = LK_Step(gx, gy,gt,window);
   U = U+ u;
   V= V + v;
   for k = s:-1:1
      currentSize =  siz((k),1:2);
      rY = currentSize(1,1);
      rX = currentSize(1,2);
      reduceR = reducesR(1:rY,1:rX,k);
      reduceL = reducesL(1:rY,1:rX,k);
   
    
    
    
    
    U = EXPAND(U);
    expandSize = size(U);
    eY = expandSize(1,1);
    eX = expandSize(1,2);
    if ~(eY == rY)
        trimY = 1;
    else
        trimY = 0;
    end
    if ~(eX == rX)
        trimX = 1;
    else
        trimX = 0;
    end
    U = 2 .* trim(U,trimY,trimX);
    V = EXPAND(V);
    
    V = 2 .* trim(V,trimY,trimX);
    
    warpR = warp(double(reduceL),U,V);
    gt = double(reduceR )- double(warpR); 
[gx, gy ] = gradient(warpR);
window = floor(rX/8);

if mod(window,2) ==0
    window = window+1;
end
[u, v] = LK_Step(gx, gy,gt,window);
U = U+ u;
V= V + v;
   end
end