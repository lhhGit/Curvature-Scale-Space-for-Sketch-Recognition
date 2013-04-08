filename = 'SR_testData\\GCVdata\\figure9';
ext = '.txt';
pList = load([filename,ext]);
%figure('NumberTitle','off','Name','raw graph'); 
%plot(pList(:,1),pList(:,2));
pList = subSample(pList,200);
sigmalist = [1;4;7;10;12;14;20;26;32];
figure('NumberTitle','off','Name','Curvature Scales');
rows = 4;
subplot(rows,3,2); 
plot(pList(:,1),pList(:,2));
isCircle = 1;
[dummy,count] = computeCSS(pList,1,isCircle);
title('raw graph');
num = 25;
cornercount = zeros(num*2-1,1);
cornercount(1) = count;
cordList = cell(num*2-1,1);
plotLoc = 4;
pointer = 1;
for i = 1 : 0.1: num
    sigma = i;  
    [smoothList,count,zeroCrossings] = computeCSS(pList,sigma,isCircle);
    %plot the smoothed curve and zero-crossing
    if ~isempty(find(sigmalist==i, 1))
        subplot(rows,3,plotLoc); 
        plot(smoothList(:,1),smoothList(:,2));
        hold on;
        plot(smoothList(zeroCrossings,1),smoothList(zeroCrossings,2),'r.');
        title(['sigma=',int2str(sigma)]);
        plotLoc = plotLoc + 1;
    end
    cords = [ones(count,1)*pointer,zeroCrossings];
    cordList{pointer} = cords;      
    cornercount(pointer) = count;
    pointer = pointer + 1;
end

matrix = generateCSSMatrix(cordList,length(pList));
saved = 1 - matrix;
save('CSS_FIGURE_9.mat','saved');
% plot zero-crossing count trend
figure('NumberTitle','off','Name','Corner point count trend');
plot(1:0.1:num,cornercount,'.');
% draw the CSS image 
figure('NumberTitle','off','Name','CSS Image');
CSSImage = imrotate(1-matrix,180);
imshow(CSSImage);
imwrite(CSSImage,[filename,'.jpg']);

