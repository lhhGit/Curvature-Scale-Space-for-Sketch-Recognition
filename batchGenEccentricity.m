%calculate eccentricity for a list of figures
input_directory = 'edges2\\';
dataFiles = dir(fullfile(input_directory, '*.txt'));

filenames = cell(length(dataFiles),1);
for i=1:length(filenames)
    filenames(i) = {dataFiles(i).name};
end

[sorted,~] = sort_nat(filenames);

EccMatrix = zeros(length(sorted),1);

for i = 1:length(sorted)
   file = sorted(i);
   pList = load([input_directory,'\\',file{1}]);
   X = pList(:,1); Y = pList(:,2);
   result = calculate_eccentricity(X,Y);
   ecc = result(6);
   disp([file{1},' eccentricity: ',num2str(ecc),' , count: ',num2str(i)]); 
   EccMatrix(i) = ecc;
end