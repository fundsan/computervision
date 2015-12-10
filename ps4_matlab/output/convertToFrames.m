function frame = convertToFrames(mask, angles)
pointsNumber = sum(mask(:));
frame = zeros(4,pointsNumber);
[ysize, xsize] = size ( mask);
current = 1;
for y = 1:ysize
    for x = 1:xsize
        if mask(y,x) == 1
            frame(:,current) = [x;y;5;angles(y,x)];
            current = current +1; 
        end
    end
end
end



