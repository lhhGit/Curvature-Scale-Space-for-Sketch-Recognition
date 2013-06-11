function [ cost ] = matchingCustomSingleNode( CSS_I, CSS_M )
%MATCHING Matching algorithm of two CSS images
%   cost   The matching cost
%   CSS_I, CSS_M   The two input CSS binary images, belongs to image and
%   model respectively, the first dimension correspond to y coord, and the
%   second dimension correspond to x coord

%   extract the maximas
[cord_I_y,cord_I_x] = find(CSS_I == 0);
[cord_M_y,cord_M_x] = find(CSS_M == 0);
cord_I = [cord_I_y,cord_I_x];
cord_M = [cord_M_y,cord_M_x];
maximas_I = extractMaxima(cord_I,CSS_I);
maximas_M = extractMaxima(cord_M,CSS_M);

%if either of the size of the maximas set is less than 2, then return the difference of the sum 
len1 = size(maximas_I,1);
len2 = size(maximas_M,1);
if(len1 == len2)
   cost = abs(sum(maximas_I(:,1)) - sum(maximas_M(:,1)));
   return
else
   if(len1 < len2)
      smaller = [maximas_I;zeros(len2-len1,2)];
      greater = maximas_M;
   else
      smaller = [maximas_M;zeros(len1-len2,2)];
      greater = maximas_I;
   end
   cost = abs(sum(smaller(:,1)) - sum(greater(:,1)));  
end    

end

