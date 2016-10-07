function [minDistances, index] = CalculateWeightedDistances(distances, indeces, sigma_d)

g = normrnd(0,sigma_d);
dij = distances.*(1-g);

minDistances = min(dij);
indexTmp= find(minDistances(1) == dij);

index = indeces(indexTmp(1));





