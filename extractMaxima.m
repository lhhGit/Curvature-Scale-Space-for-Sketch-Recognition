function [ maximas ] = extractMaxima( cords, image )
%EXTRACTMAXIMA Summary of this function goes here
%   Detailed explanation goes here
% sorted = sortrows(cords,1);
% the first element is the y cord, the second x cord
maximas = zeros(size(cords));
j = 1;
for i = 1 : size(cords,1)
     cord = cords(i,:);
     X = cord(2); Y = cord(1);
     half_range = 2;
     % check if it is the maximum
     if (X-half_range < 1)
         start_x = 1;
     else
         start_x = X - half_range;
     end
     
     if (Y-half_range < 1)
         start_y = 1;
     else
         start_y = Y - half_range;
     end
     
     if (X+half_range > size(image,2))
         ending_x = size(image,2);
     else
         ending_x = X+half_range;
     end
     
     if (Y+half_range > size(image,1))
         ending_y = size(image,2);
     else
         ending_y = Y+half_range;
     end
     
     [ycords,xcords] = find(image(start_y:ending_y,start_x:ending_x)==0);
     xcords = xcords+start_x-1;
     ycords = ycords+start_y-1;
     [maxV,dummy] = max(ycords);
     if(cord(1) >= maxV)
         %if (cord(1) > maxV)
         %    maximas(j,:) = cord;
         %else
         % if not the greatest
         %max_idxs = find(ycords==maxV);
         % clear the maximas to avoid duplicates
         %image(ycords(max_idxs),xcords(max_idxs)) = 1;
         %maximas(j,:) = mean([ycords(max_idxs),xcords(max_idxs);cord],1);
         maximas(j,:) = cord;
         %end
         j = j + 1;  
     end
end
maximas = maximas(maximas(:,1)>0,:);
maximas = sortrows(maximas,-1);
%remove the close maximas
half_range2 = 8;
for i = 1 : size(maximas,1)
    if maximas(i,1) < 1.0/6*size(image,1)
        maximas(i,:) = [0,0];
    end    
    if i<size(maximas,1) && maximas(i,1) == maximas(i+1,1) 
        if abs(maximas(i,2)-maximas(i+1,2)) < half_range2 
           maximas(i,:) = [0,0];
        end
    end
end
maximas = maximas(maximas(:,1)>0,:);
%plot(cords(:,2),cords(:,1),'.')
%hold on;
%plot(maximas(:,2),maximas(:,1),'r.');
%a = 1;


end

