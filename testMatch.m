CSS_I = load('CSS_M4.mat');
CSS_I = CSS_I.saved;
CSS_M = load('CSS_TREM_3.mat');
CSS_M = CSS_M.saved;
cost = matchingAlgo(CSS_M,CSS_I);
disp(['cost is: ', num2str(cost)]);