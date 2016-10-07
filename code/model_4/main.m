 
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
cityEastCoastIndex = GetCityEastCoast(cityPosition,gridSize);
cityPopulation = InitializeCityPopulation(nCities, minPopulation);


southCoastIndex = 1:nCities;
southCoastIndex([cityWestCoastIndex; cityEastCoastIndex]) = [];

nGenerations = 500;
westCoastWin = round(nGenerations/5);
eastCoastRecover = round(3*nGenerations/5);

fitnessBonus = 1.2;

fitness = ones(1,nCities)./nCities;

MovieHandle(nGenerations) = struct('cdata',[],'colormap',[]);
videoObj = VideoWriter('WestvsEastCoastMovie2.avi');

%h = figure('position', [560 506 800 600]);

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
    
    if n > westCoastWin && n < eastCoastRecover
        fitness = CalculateWCFitnessBonus(fitness, cityWestCoastIndex,fitnessBonus);
        titlestring = [titlestring, ' Bonus in effect'];
    end
    
    
    [pool, cityPopulation] = CreatePool(q1,sigma_q1,cityPopulation);
    cityPopulation = DistributePool(pool, cityPopulation, fitness);
    
    meanRankWestCoast(n) = FindMeanRankOfCoastCity(cityWestCoastIndex,cityPopulation);
    meanRankEastCoast(n) = FindMeanRankOfCoastCity(cityEastCoastIndex,cityPopulation);

    meanRankSouthCoast(n) = FindMeanRankOfCoastCity(southCoastIndex,cityPopulation);
    
    hold off
    
    figure(1)
    set(gca,'fontsize',15)
    subplot(1,2,1)
    hold off
    gplot(A,cityPosition,'k')
    hold on
    scatter(cityPosition(:,1),cityPosition(:,2),cityPopulation/30,'k','filled')
    hold on
    scatter(cityPosition(cityWestCoastIndex,1),cityPosition(cityWestCoastIndex,2),cityPopulation(cityWestCoastIndex)/30,'r','filled')
    hold on
    scatter(cityPosition(cityEastCoastIndex,1),cityPosition(cityEastCoastIndex,2),cityPopulation(cityEastCoastIndex)/30,'g','filled')
    
    
    subplot(1,2,2)
    PlotRankSizeEastvsWest(cityPopulation, cityWestCoastIndex, cityEastCoastIndex);
    drawnow;
    xlabel('rank')
    ylabel('population size')
    
    title(titlestring)
    A = zeros(gridSize);  

    open(videoObj);
    writeVideo(videoObj,getframe(figure(1)));
    
end


close(videoObj);


figure
set(gca,'fontsize',15)
plot(1:nGenerations,1./meanRankWestCoast,'r','linewidth',2)
hold on
plot(1:nGenerations,1./meanRankEastCoast,'g','linewidth',2)
hold on
plot(1:nGenerations,1./meanRankSouthCoast,'k','linewidth',2)
xlabel('Generations')
ylabel('1/<rank>')
