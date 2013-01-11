directory = 'Dataset';
results = dir(directory);
filelist = results(3:end);
i = 1;
while(filelist(i).name(1) == '.')
    i = i+1;
end
matrixlist = cell(1,length(filelist)+1 - i);
filelist = filelist(i:end);
for j = i:length(filelist)
   file = filelist(j);
   css_struct = load([directory ,'\\' , file.name],'saved');
   matrixlist{j-i+1} = css_struct.saved;
end

CSS_I = matrixlist{1};
for k = 1:length(matrixlist)
    cost = matchingAlgo(CSS_I, matrixlist{k});
    disp([filelist(k).name,' cost : ',num2str(cost)]);
end