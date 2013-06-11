input_directory = 'edges2\\';
output_directory = 'Dataset\\Dataset2_count_692\\';
dataFiles = dir(fullfile(input_directory, '*.txt'));
for i = 1:length(dataFiles)
   filename = dataFiles(i).name; 
   disp(filename);
   generateCSS([input_directory,filename], [output_directory,filename]);
end