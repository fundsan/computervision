function new_img = contrast(img)
    degree = .1;
    new_img = zeros(size(img,1),size(img,2));
    high_degree= 1 + degree;
    low_degree = 1 - degree;
    low_in = img< 128 ;
    new_img(low_in) = img(low_in) .* low_degree;
    new_img(~(low_in)) = img(~(low_in)) .* high_degree;
    
end