function position = InitializeCityPosition( gridSize, N )
% InitializeCityPosition 

X = randi([0 gridSize],N,1);
Y = randi([0 gridSize],N,1);
position = [X, Y];
