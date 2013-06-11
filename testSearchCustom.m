directory = 'SR_testData\\MPEGdata';
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

%comment this line if input_index is set outside
input_index = 1;

inputfile = 'inputSet\\count53\\horseshoe-1.sketch';
CSS_I = generateCSS(inputfile, inputfile);

len = length(matrixlist);
costList = zeros(len,1);
for k = 1:len
    temp = sorted(k);
    disp(['match with',temp{1}]);
    cost = matchingAlgo(CSS_I, matrixlist{k});
    costList(k) = cost;
end

[Y,I] = sort(costList);

%take the top 20 as the query result
count = 20;
resultY = Y(1:count,:);
resultI = I(1:count,:);

for i=1:length(resultY)
   value = resultY(i);
   index = resultI(i);
   file = sorted(index);
   disp([file{1},' cost: ',num2str(value)]); 
end

%display first top-20 elements 
rows = 4;
cols = 5;

figure('NumberTitle','off','Name','Input Image');
img_dir = 'original';
input_plot = load(inputfile);
input_plot(:,2) = - input_plot(:,2);
plot(input_plot(:,1),input_plot(:,2)); 
axis off;
%title('input image');

figure('NumberTitle','off','Name','Result');
for i=1:length(resultY)
   index = resultI(i);
   file = sorted(index);
   cssname = file{1};
   imgname = strrep(cssname, '.txt.mat','');
   subplot(rows,cols,i);
   imshow(255*imread([img_dir,'\\',imgname]));
   title(['cost = ',num2str(resultY(i))]);
end

 
%