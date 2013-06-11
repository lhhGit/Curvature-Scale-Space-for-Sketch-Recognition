CSS_I = load('SR_testData\\MPEGdata\\face-1.gif.txt.mat');
CSS_I = CSS_I.saved;
CSS_M = load('SR_testData\\MPEGdata\\face-1.gif.txt.mat');
CSS_M = CSS_M.saved;
cost = matchingAlgo(CSS_M,CSS_I);
disp(['cost is: ', num2str(cost)]);