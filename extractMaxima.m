function [ maximas ] = extractMaxima( cords, image )
%EXTRACTMAXIMA Summary of this function goes here
%   Detailed explanation goes here
% sorted = sortrows(cords,1);
% the first element is the y cord, the second x cord
maximas = zeros(size(cords));
j = 1;
for i = 1 : size(cords,1)
     cord = cords(i,:);
     X = cord(2);
     half_range = 4;
     % check if it is the maximum
     if (X-half_range < 1)
         start = 1;
     else
         start = X - half_range;
     end
     
     if (X+half_range > size(image,2))
         ending = size(image,2);
     else
         ending = X+half_range;
     end
     
     [ycords,xcords] = find(image(:,start:ending)==0);
     xcords = xcords+start-1;
     [maxV,dummy] = max(ycords);
     if(cord(1) >= maxV)
         if (cord(1) > maxV)
             maximas(j,:) = cord;
         else
         % if not the greatest
         max_idxs = find(ycords==maxV);
         % clear the maximas to avoid duplicates
         image(ycords(max_idxs),xcords(max_idxs)) = 1;
         maximas(j,:) = mean([ycords(max_idxs),xcords(max_idxs);cord],1);  
         end
         j = j + 1;  
     end
end
plot(cords(:,2),cords(:,1),'.')
hold on;
plot(maximas(:,2),maximas(:,1),'r.');
a = 1;


end

