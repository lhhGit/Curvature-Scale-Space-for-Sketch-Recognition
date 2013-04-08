function [ output ] = generateCSS( filename,outputdirectory )
%GENERATECSS Summary of this function goes here
%   Detailed explanation goes here
pList = load(filename);
pList = subSample(pList,200);
isCircle = 1;
[dummy,count] = computeCSS(pList,1,isCircle);
num = 25;
cornercount = zeros(num*2-1,1);
cornercount(1) = count;
cordList = cell(num*2-1,1);
pointer = 1;
for i = 1 : 0.1: num
    sigma = i;  
    [smoothList,count,zeroCrossings] = computeCSS(pList,sigma,isCircle);
    cords = [ones(count,1)*pointer,zeroCrossings];
    cordList{pointer} = cords;      
    cornercount(pointer) = count;
    pointer = pointer + 1;
end

matrix = generateCSSMatrix(cordList,length(pList));
saved = 1 - matrix;
output = saved;
save([outputdirectory, '.mat'],'saved');
CSSImage = imrotate(1-matrix,180);
%imshow(CSSImage);
imwrite(CSSImage,[outputdirectory,'.jpg']);



end

