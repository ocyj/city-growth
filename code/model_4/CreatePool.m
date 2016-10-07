function [pool, cityPopulation] = CreatePool(q1,sigma_q1,cityPopulation)

N = length(cityPopulation);

r = normrnd(q1,sigma_q1,1,N);
peopleMoving = r.*cityPopulation;
cityPopulation = cityPopulation - peopleMoving;
pool = sum(peopleMoving);
