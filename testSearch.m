directory = 'Dataset';
filelist = dir(fullfile(directory, '*.mat'));

for j = 1:length(filelist)
   file = filelist(j);
   css_struct = load([directory ,'\\' , file.name],'saved');
   matrixlist{j} = css_struct.saved;
end

CSS_I = matrixlist{1};
for k = 1:length(matrixlist)
    cost = matchingAlgo(CSS_I, matrixlist{k});
    disp([filelist(k).name,' cost : ',num2str(cost)]);
end