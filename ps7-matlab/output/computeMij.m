function Mij = computeMij(i,j,img)
    [Y, X, Z] = size(img);
    if Z == 3
        img = rgb2gray(img);
    end
    XRange = 1:X;
    YRange = 1:Y;
    
    newX = repmat(XRange,Y,1).^i;
    newY = repmat(YRange,X,1)'.^j;
    

    A = (newX.*newY.*img);
    Mij = sum(A(:));
    