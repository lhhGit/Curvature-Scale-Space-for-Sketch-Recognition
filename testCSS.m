pList = load('normal.itf');
%figure('NumberTitle','off','Name','raw graph'); 
%plot(pList(:,1),pList(:,2));
pList = subSample(pList,200);
sigmalist = [1;4;7;10;11;12;14];
%sigmalist = 0:128;
cornercount = zeros(size(sigmalist));
len = length(sigmalist);
%assume len to be 3*n 
sm_pList = zeros([size(pList),len]);
rows = len/3 + 1;
figure('NumberTitle','off','Name','Curvature Scales');
subplot(rows,3,2); 
%plot(pList(:,1),pList(:,2));
[dummy,count] = computeCSS(pList,1);
title('raw graph'); 
cornercount(1) = count;
for i = 2 : length(sigmalist)
    sigma = sigmalist(i);
    %sm_pList(:,:,i) = GaussianSmooth(pList,sigma);
    subplot(rows,3,i+2); 
    %plot(sm_pList(:,1,i),sm_pList(:,2,i));
    [dummy,count] = computeCSS(pList,sigma);
    title(['sigma=',int2str(sigma)]);
    cornercount(i) = count;
end

% plot corner count trend
figure('NumberTitle','off','Name','Corner point count trend');
plot(sigmalist,cornercount,'.');
%for i = 1 :

