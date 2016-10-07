function cityPopulation = DistributePool(pool, cityPopulation, fitness)
% rws
totalFitness = sum(fitness);

additionalPopulation = pool*fitness./totalFitness;
cityPopulation = cityPopulation + additionalPopulation;

