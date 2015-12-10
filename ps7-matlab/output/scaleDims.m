function ScaledMatrix = scaleDims(instances)
maxes = max(instances);
for s = 1:size(maxes,2)
ScaledMatrix(:,s)  = instances(:,s) ./ maxes(1,s);
end