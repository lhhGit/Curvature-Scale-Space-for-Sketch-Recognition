input_directory = 'SR_testData\\GCVdata\\';
output_directory = 'Dataset\\Dataset1_count_243\\';
dataFiles = dir(fullfile(input_directory, '*.txt'));
for i = 1:length(dataFiles)
   filename = dataFiles(i).name; 
   generateCSS([input_directory,filename], [output_directory,filename]);
end