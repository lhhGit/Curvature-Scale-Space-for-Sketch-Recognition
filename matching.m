function [ cost ] = matching( CSS_I, CSS_M )
%MATCHING Matching algorithm of two CSS images
%   cost   The matching cost
%   CSS_I, CSS_M   The two input CSS binary images, belongs to image and
%   model respectively

%   extract the maximas
[cord_I_y,cord_I_x] = find(CSS_I == 0);
[cord_M_y,cord_M_x] = find(CSS_M == 0);
cord_I = [cord_I_y,cord_I_x];
cord_M = [cord_M_y,cord_M_x];
maximas_I = extractMaxima(cord_I,CSS_I);
maximas_M = extractMaxima(cord_M,CSS_M);
%   find the two largest values of the CSS image of image
temp_I = maximas_I(:,2);
temp_M = maximas_M(:,2);
n = 100;
i = 1;
for j = 1:2
    [maxima_I_ini, idx_I] = max(temp_I);
    maxima_I = cord_I(idx_I,:);
    % find corresponding maximas in the model
    [dummy, idx_M] = max(temp_M);
    maxima_M = cord_M(idx_M,:);
    nodelist(i) = createNode(maxima_I,maxima_M);
    temp_M(idx_M) = 0;
    % if there are more than one maximums in the model that are 80% close
    % to the current maximum in the image
    while(1)
       [dummy, idx_M] = max(temp_M);
       if(dummy < maxima_I_ini*0.8)
          break
       end
       i = i + 1;
       maxima_M = cord_M(idx_M,:);
       nodelist(i) = createNode(maxima_I,maxima_M);
       temp_M(idx_M) = 0;
       disp(['create the %dth node',num2str(i)]);
    end
    nodelist(i).mList = 1;
    temp_I(idx_I) = 0;
    i = i + 1;
end
a = 1;


end

