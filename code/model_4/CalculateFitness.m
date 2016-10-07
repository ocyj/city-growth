function fitness = CalculateFitness(y)
N = length(y);
fitness = logspace(-1,1,N);

[~, index] = sort(y);

fitness(index) = fitness;