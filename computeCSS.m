function [ smoothList,count] = computeCSS( pointList,sigma)
%COMPUTECSS compute the Curvature Scale Space of the given pointList
%   pointList a list of points [0,0;1,1]

% the normal approach for computing curvature
dim = floor(size(pointList,1)*1.0);
if mod(dim,2) == 0
   dim = dim + 1;
end
kernel_0 = DerivGaussianKernel(dim,sigma,0);
kernel_1 = DerivGaussianKernel(dim,sigma,1);
kernel_2 = DerivGaussianKernel(dim,sigma,2);
X = pointList(:,1); Y = pointList(:,2);
smoothX = myConv(kernel_0,X);
smoothY = myConv(kernel_0,Y);
smoothList = [smoothX,smoothY];
fODrvtvX = myConv(kernel_1,X);
fODrvtvY = myConv(kernel_1,Y);
sODrvtvX = myConv(kernel_2,X);
sODrvtvY = myConv(kernel_2,Y);
curvatures = (fODrvtvX.*sODrvtvY - fODrvtvY.*sODrvtvX) ... 
             ./(fODrvtvX.^2 + fODrvtvY.^2).^1.5 ;
         
%figure;
%plot(curvatures);
idxs = [];
for i = 1 : length(curvatures)-1
    if curvatures(i)*curvatures(i+1) <= 0
        idxs = [idxs;i];
    end
end
% get derivative zero crossings
% maximas = computeDerivative(1,curvatures);
% idxs = find(abs(maximas) <= 0.000001);

count = length(idxs);
plot(smoothX,smoothY);
hold on;
plot(smoothX(idxs),smoothY(idxs),'r.');
end

