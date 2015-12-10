function [mse,particle_patch] = particle_mse_appearance(y,x, temp, img,sigma,dist_sig)
    
   [tempy, tempx,tempz] = size(temp);
   [imgy, imgx, imgz] = size(img);
    check_y_low= ceil(y - (tempy/2));
    check_x_low = ceil(x - (tempx/2));   
    check_y_high= floor(y + (tempy/2));
    check_x_high = floor(x + (tempx/2));
    while (check_y_low < 1 || check_x_low < 1 || check_y_high > imgy || check_x_high > imgx)
        y = round(normrnd(450,dist_sig))';
        x = round(normrnd(576,dist_sig))';
            check_y_low= ceil(y - (tempy/2));
            check_x_low = ceil(x - (tempx/2));   
            check_y_high= floor(y + (tempy/2));
             check_x_high = floor(x + (tempx/2));
    end 
    
        particle_patch = img(check_y_low:check_y_high,check_x_low:check_x_high,:);
        
        mse = ((double(particle_patch) - double(temp)).^2)./(tempy*tempx*tempz);
        mse = sum(mse(:));
        mse = exp((-mse)/(2*sigma*sigma));
    end
        