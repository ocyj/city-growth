function index = GetCityEastCoast(cityPositions,gridSize)

cond1 = cityPositions(:,1) > gridSize/2;
cond2 = cityPositions(:,2) > gridSize/2;

index = find(cond1 & cond2);
