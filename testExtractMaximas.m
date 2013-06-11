directory = 'SR_testData\\MPEGdata';
filelist = dir(fullfile(directory, '*.mat'));

filenames = cell(length(filelist),1);
for i=1:length(filenames)
    filenames(i) = {filelist(i).name};
end

[sorted,~] = sort_nat(filenames);
maximaList = zeros(length(sorted),1);

for j = 1:length(sorted)
   file = sorted(j);
   css_struct = load([directory ,'\\' , file{1}],'saved');
   CSS_I = css_struct.saved;
   [cord_I_y,cord_I_x] = find(CSS_I == 0);
   cord_I = [cord_I_y,cord_I_x];
   maximas_I = extractMaxima(cord_I,CSS_I);
   if(~isempty(maximas_I))
      maximaList(j) = max(maximas_I(:,1));
   end
end


