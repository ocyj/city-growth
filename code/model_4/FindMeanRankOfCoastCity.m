function meanRank = FindMeanRankOfCoastCity(coastIndex,population)

[~, idx] = sort(population,'descend');


tmp = zeros(length(coastIndex),1);
for i = 1:length(coastIndex)
    tmp(i) = find(idx == coastIndex(i));
end

meanRank = mean(tmp);
