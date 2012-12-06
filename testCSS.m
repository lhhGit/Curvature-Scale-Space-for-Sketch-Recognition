pList = load('normal.itf');
%figure('NumberTitle','off','Name','raw graph'); 
%plot(pList(:,1),pList(:,2));
pList = subSample(pList,200);
sigmalist = [1;4;7;10;12;14];
figure('NumberTitle','off','Name','Curvature Scales');
subplot(4,3,2); 
plot(pList(:,1),pList(:,2));
[dummy,count] = computeCSS(pList,1);
title('raw graph');
num = 50;
cornercount = zeros(num*2-1,1);
cornercount(1) = count;
cordList = cell(num*2-1,1);
plotLoc = 4;
pointer = 1;
for i = 1 : 0.5: num
    sigma = i;  
    [smoothList,count,zeroCrossings] = computeCSS(pList,sigma);
    %plot the smoothed curve and zero-crossing
    if ~isempty(find(sigmalist==i, 1))
        subplot(4,3,plotLoc); 
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
% plot zero-crossing count trend
figure('NumberTitle','off','Name','Corner point count trend');
plot(1:0.5:num,cornercount,'.');
% draw the CSS image 
figure('NumberTitle','off','Name','CSS Image');
imshow(imrotate(1-matrix,180));

