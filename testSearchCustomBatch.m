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

input_directory = 'inputSet\\count53\\';
input_filelist = dir(fullfile(input_directory, '*.sketch'));
cate_count = load('SR_testData\\MPEGdata\\catecount.log');

input_filenames = cell(length(input_filelist),1);

for i=1:length(input_filenames)
    input_filenames(i) = {input_filelist(i).name};
end

[input_filenames,~] = sort_nat(input_filenames);

result = zeros(length(cate_count),5);
for i=1:length(input_filenames)
    file = input_filenames(i);
    inputfile = [input_directory,file{1}];
    CSS_I = generateCSS(inputfile,inputfile);
    disp(['search with: ',file{1}]);
    if(i == 1)
        start_index = 1;
    else
        start_index = cate_count(1:i-1) + 1;
    end
    [p5,p10,p20,recall] = SearchCustom(CSS_I, file{1}, 0, start_index, cate_count(i));
    result(i,1) = recall;
    result(i,2) = recall*1.0/cate_count(i);
    result(i,3) = p5;
    result(i,4) = p10;
    result(i,5) = p20;
end
