function [distances, cityIndex] = FindDistances(cityPosition,cityPopulation,iCityIndex)
% cities j with larger population size than city i
cityIndex = find(cityPopulation > cityPopulation(iCityIndex));

if isempty(cityIndex)
    %disp('greatest city!')
    distances = 0;
    cityIndex = 0;
    % NEED TO HANDLE THE CASE WHEN WE FIND NO BIGGER CITY
else    
    jCities = cityPosition(cityIndex,:);
    
    N = size(jCities,1);
    iCity = cityPosition(iCityIndex,:);
    
    for j = 1:N
        distances(j) = sqrt(sum((jCities(j,:)-iCity).^2));
    end 
end