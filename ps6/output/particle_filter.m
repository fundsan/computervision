function S = particle_filter(prevS,img,sigma, patch)
[ysize, xsize, zsoze] = size(img);
[particles_size,attr] = size(prevS);
N = 0;
best_weight= Inf;
best_n = 0;

particles_prime = systematic_resampling(prevS(:,1:2),prevS(:,3));

S= zeros(particles_size,3);
for n = 1:particles_size
    if mod(n,10) == 0
        y = randi([1 ysize],1,1)';
        x = randi([1 xsize],1,1)';
    else
    particle = particles_prime(n,:);
    y = particle(1);
    x = particle(2);
    end
    ynoise = round(10*randn(1,1)) ;
    xnoise = round(10*randn(1,1)) ;
    
    y = y+ynoise;
    x = x+xnoise;
    weight = particle_mse(y,x,patch, img,sigma);
    if weight < best_weight
        best_weight = weight;
        best_n = n;
    end
    N = weight + N;
    S(n,:) = [y,x,weight];
end
S(:,3) = S(:,3)./N;
end
    
    
    