function bestRs = FindBestPointsHarris(R, windowsize, threshold)
    [ysize, xsize] = size(R);
   
    filtered = R > threshold;
    R(~filtered) = 0;
    padding = windowsize;
    halfpad = floor(padding/2);
    paddedR = zeros(padding+ysize+padding, padding+xsize+padding);
    paddedR((padding+1):(ysize+padding),(padding+1):(xsize+padding)) = R;
    for y = (padding+1):(padding+ysize)
        for x = (padding+1):(padding+xsize)
            value = paddedR(y,x);
            if value == 0
                continue;
            end
            window = paddedR((y-halfpad):(y+halfpad),(x-halfpad):(x+halfpad));
            M = max(window(:));
            
           if ~(M == value)
                
                R(y-padding, x-padding) = 0;
            end
        end
    end
    bestRs = R > 0;
    
   