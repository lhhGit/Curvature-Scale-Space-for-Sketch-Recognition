function [ smoothedList ] = GaussianSmooth( pointList, sigma)
%GAUSSIANSMOOTH Summary of this function goes here
%   Detailed explanation goes here
dim = floor(size(pointList,1)*0.12);
if mod(dim,2) == 0
   dim = dim + 1;
end
kernel = fspecial('gaussian',[dim,1],sigma);
%kernel = ones(size,1)*1.0/size;
%extendedX = [pointList(:,1)];
%extendedY = [pointList(:,2)];
smoothedListX = myConv(kernel,pointList(:,1));
smoothedListY = myConv(kernel,pointList(:,2));
smoothedList = [smoothedListX,smoothedListY];
%plot(pointList(:,1),pointList(:,2),'g');
%hold on;
%plot(smoothedList(:,1),smoothedList(:,2));
end

