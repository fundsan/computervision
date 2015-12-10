function resample = systematic_resampling(samples, weights)
resample = zeros(size(samples));
spocs = size(weights,1);
c = zeros(spocs,1);
c(1,1) = weights(1);
U = 1:spocs;
U = (U./spocs)';
for i = 2:spocs
    c(i,1) = c(i-1,1) + weights(i);
end
i=1;
for j = 1:spocs
    while(i< spocs && U(j,1)> c(i,1))
        i = i +1;
            
    end
    resample(j,:) = samples(i,:);

end
