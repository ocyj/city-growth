function fitness = CalculateWCFitnessBonus(fitness, westCoastIndex,fitnessBonus)

fitnessMean = mean(fitness);
fitness(westCoastIndex) = fitness(westCoastIndex) + fitnessBonus*fitnessMean;
