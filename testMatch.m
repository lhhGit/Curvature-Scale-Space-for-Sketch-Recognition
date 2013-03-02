CSS_I = load('CSS_I.mat');
CSS_I = CSS_I.saved;
CSS_M = load('CSS_M5.mat');
CSS_M = CSS_M.saved;
cost = matchingAlgo(CSS_I,CSS_M);
disp(['cost is: ', num2str(cost)]);