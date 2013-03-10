directory = 'Dataset\\Dataset1_count_243';
filelist = dir(fullfile(directory, '*.mat'));

filenames = cell(length(filelist),1);
for i=1:length(filenames)
    filenames(i) = {filelist(i).name};
end

[sorted,~] = sort_nat(filenames);
matrixlist = cell(length(sorted),1);
for j = 1:length(sorted)
   file = sorted(j);
   css_struct = load([directory ,'\\' , file{1}],'saved');
   matrixlist{j} = css_struct.saved;
end

CSS_I = matrixlist{37};

len = length(matrixlist);
costList = zeros(len,1);
for k = 1:len
    cost = matchingAlgo(CSS_I, matrixlist{k});
    costList(k) = cost;
end

[Y,I] = sort(costList);
for i=1:length(Y)
   value = Y(i);
   index = I(i);
   file = sorted(index);
   disp([file{1},' cost: ',num2str(value)]); 
end