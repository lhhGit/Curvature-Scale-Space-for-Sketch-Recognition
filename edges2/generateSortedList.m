filelist = dir(fullfile('.', '*.gif'));

for i = 1391 : length(filelist)
    filename = filelist(i).name;
    img = imread(filename);
    [X,Y] = find(img > 0);
    try
     sorted = sort_coord_pixel([X,Y], 'clockwise', 'discontinous');
    catch err
     sorted = [];
    end
    f = figure('visible','off');  
    if(~isempty(sorted))
        dlmwrite([filename,'.txt'], sorted, ' ');
        plot(sorted(:,1),sorted(:,2));
        axis off;
        print(f, '-r80', '-djpeg90', [filename,'.jpg']);
        disp(['generated ', int2str(i)]);
        continue;
    end
    disp(['failed ', int2str(i)]);

end