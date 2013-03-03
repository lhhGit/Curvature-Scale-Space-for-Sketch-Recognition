directory = 'Dataset\\RotationInvariantTest';
dataFiles = dir(fullfile(directory, '*.txt'));
for i = 1:length(dataFiles)
    filename = dataFiles(i).name;
    generateCSS([directory,'\\',filename]);
end