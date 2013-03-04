directory = '.';
dataFiles = dir(fullfile(directory, '*.txt'));
filenames = cell(length(dataFiles),1);
sorted = sort_nat(filenames);
for i = 1:length(sorted)
    current = sorted(i);
    if(length(filename) < 14)
        f = figure('visible','off');   
        img = load(filename);
        plot(img(:,1),img(:,2));
        axis off;
        print(f, '-r80', '-djpeg90', [filename,'.jpg']);
    end
end