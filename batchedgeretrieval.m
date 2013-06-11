directory = 'original';
output = 'edges2';
filelist = dir(fullfile(directory, '*.gif'));

for i = 1:length(filelist)
   filename = filelist(i).name;
   img = imread([directory,'\\',filename]);
   im_bw = false(size(img));
   mtx = find(img > 0);
   im_bw(mtx) = true;
   im_bw(~mtx) = false;
im2=imfill(im_bw,'holes');             %Ìî³ä
im3=bwperim(im2, 8);                   %ÂÖÀªÌáÈ¡
  imwrite(im3, [output,'\\',filename]);
end