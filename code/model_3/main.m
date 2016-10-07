 
clc 
clear all

nCities = 100;
gridSize = 1000;
minPopulation = 1000;
sigma_d = 0.2;
sigma_p = 0.5;
alpha = 0.9;
A = zeros(gridSize);
q1 = 0.05;
sigma_q1 = 0.01;

cityPosition = InitializeCityPosition(gridSize,nCities);
cityWestCoastIndex = GetCityWestCoastForTheWin(cityPosition,gridSize);
cityPopulation = InitializeCityPopulation(nCities, minPopulation);

nGenerations = 500;
westCoastWin = round(nGenerations/10);
fitnessBonus = 3;

fitness = ones(1,nCities)./nCities;

for n = 1:nGenerations
    tradingCities = cell(nCities,1);
    tradingPopulationSizes = zeros(1,nCities);
    titlestring = ['Generation:', num2str(n)];
    disp(n)
    
    for iCity = 1:nCities
        [distances, indexDistances] = FindDistances(cityPosition,cityPopulation,iCity);
        if distances ~= 0
            [dij, indexDij] = CalculateWeightedDistances(distances,indexDistances,sigma_d);
            tradingCities{indexDij} = [tradingCities{indexDij}, iCity];
            tradingPopulationSizes(indexDij) = tradingPopulationSizes(indexDij) + cityPopulation(iCity);
            A(iCity,indexDij) = 1;
        end
    end
    
    cityPopulationGrowth = UpdateCityPopulation(cityPopulation,alpha,tradingPopulationSizes,minPopulation,sigma_p);
    cityPopulationGrowth = round(cityPopulationGrowth);
    growthRate = (cityPopulationGrowth - cityPopulation)./cityPopulation;
    fitness = CalculateFitness(growthRate);
    if n > westCoastWin
        fitness = CalculateWCFitnessBonus(fitness, cityWestCoastIndex,fitnessBonus);
        titlestring = [titlestring, 'West Coast bonus in effect'];
    end
    
    
    [pool, cityPopulation] = CreatePool(q1,sigma_q1,cityPopulation);
    cityPopulation = DistributePool(pool, cityPopulation, fitness);
    
    
    hold off
    
    figure(1)
    subplot(1,2,1)
    hold off
    gplot(A,cityPosition,'k')
    hold on
    scatter(cityPosition(:,1),cityPosition(:,2),cityPopulation/30,'k','filled')
    hold on
    scatter(cityPosition(cityWestCoastIndex,1),cityPosition(cityWestCoastIndex,2),cityPopulation(cityWestCoastIndex)/30,'r','filled')
    
    subplot(1,2,2)
    PlotRankSize(cityPopulation, cityWestCoastIndex);
    drawnow;
    
    title(titlestring)
    A = zeros(gridSize);  
    
end



