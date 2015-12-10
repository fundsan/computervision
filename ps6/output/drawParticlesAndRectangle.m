function newImg = drawParticlesAndRectangle(img, particles, rectangle)
    particles_n = size(particles,1);
    newImg = zeros(size(img),'uint8');
    [imgy, imgx, imgz] = size(newImg);
    for n = 1:particles_n
        yp = particles(n,1);
        xp = particles(n,2);
        if ( yp > 0 && yp <= imgy && xp> 0 && xp<= imgx)
            newImg(yp,xp,:) = [255,0,0];
        end
    end
    
    ty = rectangle(1,1);
    by = rectangle(1,2);
    lx = rectangle(1,3);
    rx = rectangle(1,4);
    y_size = by - ty; 
    x_size = rx - lx; 
    for n = 1:y_size
        if(ty-1+n> 0 && ty-1+n< imgy && lx> 0 && lx< imgx)
        newImg(ty-1+n,lx,:) = [255,255,0];
        end
        if(ty-1+n> 0 && ty-1+n< imgy && rx> 0 && rx< imgx)
        newImg(ty-1+n,rx,:) = [255,255,0];
        end
    end
    for n = 1:x_size
        if(lx-1+n> 0 && lx-1+n<= imgx && ty> 0 && ty<= imgy)
        newImg(ty,lx-1+n,:) = [255,255,0];
        end
        if(lx-1+n> 0 && lx-1+n<= imgx && by> 0 && by<= imgy)
        newImg(by,lx-1+n,:) = [255,255,0];
        end
    end
    newImg = newImg+img;
    