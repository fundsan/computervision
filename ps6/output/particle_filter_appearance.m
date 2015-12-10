function [S,best_patch] = particle_filter_appearance(prevS,img,sigma,dist_sig,noise_sigma, patch)
[ysize, xsize, zsoze] = size(img);
[particles_size,attr] = size(prevS);
N = 0;
best_weight= Inf;
best_patch = 0;

particles_prime = systematic_resampling(prevS(:,1:2),prevS(:,3));

S= zeros(particles_size,3);
for n = 1:particles_size
    if mod(n,10) == 0
        y = round(normrnd(450,dist_sig))';
        x = round(normrnd(576,dist_sig))';
    else
    particle = particles_prime(n,:);
    y = particle(1);
    x = particle(2);
    end
    ynoise = round(normrnd(0,noise_sigma)) ;
    xnoise = round(normrnd(0,noise_sigma)) ;
    
    y = y+ynoise;
    x = x+xnoise;
    [weight,particle_patch] = particle_mse_appearance(y,x,patch, img,sigma,dist_sig);
    if weight < best_weight
        best_weight = weight;
        best_particle = particle_patch;
    end
    N = weight + N;
    S(n,:) = [y,x,weight];
end
S(:,3) = S(:,3)./N;
end
    
    
    