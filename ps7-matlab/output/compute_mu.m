function mu = compute_mu(M00, M10, M01, img,p,q) 
    xMu = M10/ M00;
    yMu = M01/ M00;
    
    [Y X] = size(img);
    XRange = 1:X;
    YRange = 1:Y;
    
    newX = repmat(XRange,Y,1);
    newY = repmat(YRange,X,1)';
    
    
    newX = (newX - xMu).^p;
    newY = (newY - yMu).^q;
    A = (newX.*newY.*img);
    mu = sum(A(:));
    
    