CSS_I = load('Dataset\\Dataset1_count_243\\figure1.txt.mat');
CSS_I = CSS_I.saved;
CSS_M = load('Dataset\\Dataset1_count_243\\figure12.txt.mat');
CSS_M = CSS_M.saved;
cost = matchingAlgo(CSS_M,CSS_I);
disp(['cost is: ', num2str(cost)]);