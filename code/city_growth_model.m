clc 
clear all

nCities = 100;
gridSize = 1000;
minPopulation = 1000;
sigma_d = 0.2;
sigma_p = 0.5;
alpha = 0.9;
A = zeros(gridSize);

cityPosition = InitializeCityPosition(gridSize,nCities);
cityPopulation = InitializeCityPopulation(nCities, minPopulation);

nGenerations = 100;

for n = 1:nGenerations
    tradingCities = cell(nCities,1);
    tradingPopulationSizes = zeros(1,nCities);
    
    for iCity = 1:nCities
        [distances, indexDistances] = FindDistances(cityPosition,cityPopulation,iCity);
        if distances ~= 0
            [dij, indexDij] = CalculateWeightedDistances(distances,indexDistances,sigma_d);
            tradingCities{indexDij} = [tradingCities{indexDij}, iCity];
            tradingPopulationSizes(indexDij) = tradingPopulationSizes(indexDij) + cityPopulation(iCity);
            A(iCity,indexDij) = 1;
        end
    end
    
    cityPopulation = UpdateCityPopulation(cityPopulation,alpha,tradingPopulationSizes,minPopulation,sigma_p);
    cityPopulation = round(cityPopulation);
    
    hold off
    
    figure(1)
    subplot(1,2,1)
    hold off
    gplot(A,cityPosition,'k')
    hold on
    scatter(cityPosition(:,1),cityPosition(:,2),cityPopulation/70,'k','filled')
    
    subplot(1,2,2)
    cityPopulationTmp = sort(cityPopulation,'descend');
    loglog(1:nCities,cityPopulationTmp)

    drawnow;
    
    A = zeros(gridSize);  
    
end



