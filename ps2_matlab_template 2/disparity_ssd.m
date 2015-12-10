function D = disparity_ssd(L, R, boxsize, depthrange, left_to_right)
    % Compute disparity map D(y, x) such that: L(y, x) = R(y, x + D(y, x))
    %
    % L: Grayscale left image
    % R: Grayscale right image, same size as L
    % D: Output disparity map, same size as L, R
    % TODO: Your code here

    
    filter = ones(boxsize,boxsize)/(boxsize*boxsize);
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
        
        diff = rshift- L;

        diff = diff .^ 2;   

        ssd = imfilter(diff,filter,'symmetric');  

        DSI(:,:,d+1) = ssd;

end
        [M D] = min(DSI, [], 3);
        D = D - 1;
        check_d = mod(L_Grid + (D*direction), columns);
        
        
        D = L_Grid - check_d;
        
        
        
end
