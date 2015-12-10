function D = disparity_ncorr(L, R, boxsize, depthrange, left_to_right)
    % Compute disparity map D(y, x) such that: L(y, x) = R(y, x + D(y, x))
    %
    % L: Grayscale left image
    % R: Grayscale right image, same size as L
    % D: Output disparity map, same size as L, R
   
    % Compute disparity map D(y, x) such that: L(y, x) = R(y, x + D(y, x))
    %
    % L: Grayscale left image
    % R: Grayscale right image, same size as L
    % D: Output disparity map, same size as L, R
    % TODO: Your code here

    
    filter = ones(boxsize,boxsize);
    maxd = ceil((depthrange*size(L,2)))-1;
    DSI= zeros(size(L,1),size(L,2),maxd);
    rows = size(L,1);
    columns = size(L,2);
    L_Grid = zeros(rows,columns);
    direction = left_to_right;
    if ~direction
        direction = -1;
    end
    for row = 1:rows
        L_Grid(row,:) = 0:(columns-1);
    end
    
for d = 0:maxd
        next_d = d * direction;
        rshift = circshift(R,next_d,2);

        numer = (L.*rshift);
        denomL = L.^2;
        denomR = rshift.^2;
         % square the values

        corr = imfilter(numer,filter,'symmetric'); 
       
 % takes the som over the filter window
        normL = imfilter(denomL,filter, 'symmetric');
        normR = imfilter(denomR,filter, 'symmetric');
       

        denom = (normL .* normR).^.5;
       
        corrn = corr./denom;
      
        DSI(:,:,d+1) = corrn;

end
        [M D] = max(DSI, [], 3);
        D = D - 1;
        check_d = mod(L_Grid + (direction*D), columns);
        
        D = L_Grid - check_d;
        
        
        

    % TODO: Your code here
end
