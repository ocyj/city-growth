function PlotRankSize(cityPopulation, cityWestCoastIndex)
nCities = length(cityPopulation);
rank = 1:nCities;
[cityPopulation, index] = sort(cityPopulation,'descend');

cityWestCoastIndexTmp = zeros(length(cityWestCoastIndex),1);
for i = 1:length(cityWestCoastIndex)
    cityWestCoastIndexTmp(i) = find(index == cityWestCoastIndex(i));
end

cityWestCoastIndex = cityWestCoastIndexTmp;

loglog(rank,cityPopulation,'k*-');
hold on 
loglog(rank(cityWestCoastIndex),cityPopulation(cityWestCoastIndex),'r*');