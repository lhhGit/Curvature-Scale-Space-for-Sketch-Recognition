directory = '.';
dataFiles = dir(fullfile(directory, '*.txt'));
for i = 1:length(dataFiles)
    filename = dataFiles(i).name;
    figure1 = load(filename);
    for j = 1:7
        rotated = applyrotation(figure1,45*j);
        dlmwrite([filename,'_rotated_',int2str(45*j),'.txt'],rotated,' ');
    end
end




