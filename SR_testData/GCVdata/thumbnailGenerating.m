directory = '.';
dataFiles = dir(fullfile(directory, '*.txt'));
filenames = cell(length(dataFiles),1);
for i=1:length(dataFiles)
    filenames(i) = {dataFiles(i).name};
end
sorted = sort_nat(filenames);
for i = 1:length(sorted)
    file = sorted(i);
    current = file{1};
    if(length(current) < 14)
        f = figure('visible','off');   
        img = load(current);
        plot(img(:,1),img(:,2));
        axis off;
        print(f, '-r80', '-djpeg90', [current,'.jpg']);
    end
end