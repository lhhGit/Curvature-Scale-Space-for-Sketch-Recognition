directory = '.';
dataFiles = dir(fullfile(directory, '*.jpg'));
filenames = cell(length(dataFiles),1);
for i=1:length(dataFiles)
    filenames(i) = {dataFiles(i).name};
end

[sorted,~] = sort_nat(filenames);

imgrow = 48; imgcol = 64;
rows = 18; cols = 14;
Patch = ones(imgrow*rows,imgcol*cols)*255;
for i =1:length(sorted)
    filename = sorted(i);
    img = rgb2gray(imread(filename{1}));
    resized = imresize(img,[imgrow,imgcol]);
    resized(resized~=255) = 0;
    col_cord = mod(i-1,cols)+1;
    row_cord = (i-1)/cols + 1;
    Patch(imgrow*(row_cord-1)+1:imgrow*row_cord,...
    imgcol*(col_cord-1)+1:imgcol*col_cord) = resized;
end

%Patch = Patch;
imwrite(Patch,'Patch.jpg');