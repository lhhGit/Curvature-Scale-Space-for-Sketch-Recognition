function [ p5,p10,p20, recall ] = SearchCustom( CSS_I, inputcssfilename, displayResult, input_index, count)
%SEARCH Summary of this function goes here
%   Detailed explanation goes here
p5 = 0;p10=0;p20=0;
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
%input_index = 10;


len = length(matrixlist);
costList = zeros(len,1);
for k = 1:len
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
if(displayResult) 
    rows = 5;
    cols = 5;

    img_dir = 'original';
    subplot(rows,cols,3);    
    inputimgname = strrep(inputcssfilename, '.txt.mat','');
    imshow(255*imread([img_dir,'\\',inputimgname]));
    title('input image');

    for i=1:length(resultY)
       index = resultI(i);
       file = sorted(index);
       cssname = file{1};
       imgname = strrep(cssname, '.txt.mat','');
       subplot(rows,cols,i + 5);
       imshow(255*imread([img_dir,'\\',imgname]));
    end
end

%calculate precision 
p5 = 0;
p10 = 0;
p20 = 0;
hyphen_idx = find(inputcssfilename == '-');
input_catename = inputcssfilename(1:hyphen_idx-1);
match_count = 0;
for i = 1:20
    index = resultI(i);
    file = sorted(index);
    name = file{1};
    hyphen_idx = find(name == '-');
    cate_name = name(1:hyphen_idx-1);
    if( strcmp(input_catename, cate_name) )
        match_count = match_count + 1;
    end
    
    if(i == 5)
       p5 = 1.0*match_count/min(5, count);
    end
    
    if(i == 10)
        p10 = 1.0*match_count/min(10, count);
    end
    
    if(i == 20)
        p20 = 1.0*match_count/min(20, count);
    end
end

%calculate recall
same_class_index = input_index:input_index + count - 1;
ranks = zeros(length(same_class_index),1);

for i = 1:length(ranks)
    ranks(i) = find(I == same_class_index(i));
end
recall = max(ranks);

end
