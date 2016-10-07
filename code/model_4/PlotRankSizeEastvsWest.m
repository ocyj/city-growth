function PlotRankSizeEastvsWest(cityPopulation, cityWestCoastIndex, cityEastCoastIndex)
nCities = length(cityPopulation);
rank = 1:nCities;
[cityPopulation, index] = sort(cityPopulation,'descend');

cityWestCoastIndexTmp = zeros(length(cityWestCoastIndex),1);
for i = 1:length(cityWestCoastIndex)
    cityWestCoastIndexTmp(i) = find(index == cityWestCoastIndex(i));
end

cityEastCoastIndexTmp = zeros(length(cityEastCoastIndex),1);
for i = 1:length(cityEastCoastIndex)
    cityEastCoastIndexTmp(i) = find(index == cityEastCoastIndex(i));
end

cityWestCoastIndex = cityWestCoastIndexTmp;
cityEastCoastIndex = cityEastCoastIndexTmp;

loglog(rank,cityPopulation,'k*-');
hold on 
loglog(rank(cityWestCoastIndex),cityPopulation(cityWestCoastIndex),'r*');
hold on
loglog(rank(cityEastCoastIndex),cityPopulation(cityEastCoastIndex),'g*');