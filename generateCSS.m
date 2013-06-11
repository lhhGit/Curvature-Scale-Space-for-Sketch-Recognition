function [ saved ] = generateCSS( filename,outputdirectory )
%GENERATECSS Summary of this function goes here
%   Detailed explanation goes here
pList = load(filename);
pList = subSample(pList,200);
isCircle = 1;
[~,count] = computeCSS(pList,1,isCircle);
num = 60;
cornercount = zeros(num*2-1,1);
cornercount(1) = count;
cordList = {};
pointer = 1;
sigma = 0;
i = 1;
while(true)
    sigma = i;  
    [~,count,zeroCrossings] = computeCSS(pList,sigma,isCircle);
    %disp([num2str(sigma),',',num2str(count)]);
    %if will be visualized as an image, then use the line below, otherwise
    %use next line
    %Y = pointer;   
    if(count == 0 || i > num)
        break;
    end
    Y = sigma;
    cords = [ones(count,1)*Y,zeroCrossings];
    cordList{pointer} = cords;      
    cornercount(pointer) = count;
    pointer = pointer + 1;
    i = i + 0.1;
end

output = generateCSSCordList(cordList);
%transform X cords to integer
xint_cordList = output;
X = xint_cordList(:,1);
X = floor((X - 1)/0.1 + 1);
xint_cordList(:,1) = X;
saved = true(length(cordList),length(pList));
%convert row and column subscripts to linear indices
saved(sub2ind(size(saved),xint_cordList(:,1),xint_cordList(:,2))) = 0;
%matrix = generateCSSMatrix(cordList,length(pList));
%saved = 1 - matrix;
%output = saved;
save([outputdirectory, '.mat'],'saved');
%CSSImage = imrotate(1-matrix,180);
%imshow(CSSImage);
f = figure('visible','off');
plot(output(:,2),output(:,1),'.');
axis([0,200,1,sigma + 5]);
print(f,'-dpng',[outputdirectory,'.jpg']);
%imwrite(CSSImage,[outputdirectory,'.jpg']);
%a = 1;


end

