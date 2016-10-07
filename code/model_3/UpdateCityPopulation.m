function population = UpdateCityPopulation(cityPopulation,alpha,tradingPopulationSizes,pmin,sigma_p)

N = length(cityPopulation);
population = zeros(1,N);

for j = 1:N
    g = normrnd(0,sigma_p);
    population(j) = alpha*tradingPopulationSizes(j) + pmin*(1 + g);
    if population(j) < 0
        population(j) = -1*population(j);
    end
end

