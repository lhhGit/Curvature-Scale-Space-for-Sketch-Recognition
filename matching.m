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
temp_I = maximas_I(:,1); %copy of the maxima sigmas in the image
temp_M = maximas_M(:,1); %copy of the maxima sigmas in the model

%is either of the maximas set is empty, then return the sum of the other
%maximas as the cost
if(isempty(maximas_I)||isempty(maximas_M))
    if isempty(maximas_I)        
        cost = sum(maximas_M(:,1));
        return
    else
        cost = sum(maximas_I(:,1));
        return
    end
end

% n = 100;
i = 1;
for j = 1:2
    [maxima_I_ini, idx_I] = max(temp_I);
    maxima_I = maximas_I(idx_I,:);
    % find corresponding maximas in the model
    [dummy, idx_M] = max(temp_M);
    maxima_M = maximas_M(idx_M,:);
    nodelist(i) = createNode(maxima_I,maxima_M);
    %if added to nodelist, then remove from the to-add list
    temp_I(idx_I) = 0;
    temp_M(idx_M) = 0;
    maximas_I(idx_I,:) = [0,-Inf];
    maximas_M(idx_M,:) = [0,-Inf];
    %temp_I = temp_I(temp_I>0);
    %temp_M = temp_M(temp_M>0);
    % if there are more than one maximums in the model that are 80% close
    % to the current maximum in the image
    while(~isempty(find(temp_M > 0, 1)))
       [dummy, idx_M] = max(temp_M);
       if(dummy < maxima_I_ini*0.8 || dummy > maxima_I_ini*1.25)
          break
       end
       i = i + 1;
       maxima_M = maximas_M(idx_M,:);
       nodelist(i) = createNode(maxima_I,maxima_M);
       temp_M(idx_M) = 0;
       maximas_M(idx_M,:) = [0,-Inf];
       %temp_M = temp_M(temp_M>0);
       %disp(['create the %d th node',num2str(i)]);
    end
    i = i + 1;
end

%expand nodes 
half_range = 0.2 * size(CSS_I,2);
while(~isempty(find(temp_I > 0, 1)) || ~isempty(find(temp_M > 0, 1)))
    % get the lowest cost node
    k = 1;
    cost = nodelist(1).cost;
    for m = 2:length(nodelist)
        if nodelist(m).cost < cost
            k = m;
            cost = nodelist(m).cost;
        end
    end
    shift = nodelist(k).shift;
    if ~isempty(find(temp_I > 0,1))
        [maxima_I_y, idx_I] = max(temp_I);
        current_maxima = maximas_I(idx_I,:);
        temp_I(idx_I) = 0;
        maximas_I(idx_I,:) = [0,-Inf];
        %temp_I = temp_I(temp_I>0);
        % find the corresponding match in the model
        pivot = current_maxima(:,2) + shift;
        if ~isempty(find(temp_M > 0,1))    
            [dummy,idx] = min(abs(temp_M - pivot));
            matched = maximas_M(idx,:);
            if isInRange(matched(2),pivot-half_range,pivot+half_range,size(CSS_I,2))
            %update cost
                nodelist(k).cost = nodelist(k).cost + abs(matched(1) - current_maxima(1));        
            else
                nodelist(k).cost = nodelist(k).cost + current_maxima(1); 
            end
            %update list
            nodelist(k).listSize = nodelist(k).listSize + 1;
            nodelist(k).iList(nodelist(k).listSize,:) = maxima_I;
            nodelist(k).mList(nodelist(k).listSize,:) = matched;
            temp_M(idx) = 0;
            maximas_M(idx,:) = [0,-Inf];
            %temp_M = temp_M(temp_M>0);
        else
            %if there are no more maximums in the model
            nodelist(k).cost = nodelist(k).cost + current_maxima(1);
        end
    else
        %if there are no more maximums in the image
        if ~isempty(find(temp_M > 0,1)) 
            [dummy,idx] = max(temp_M);
            matched = maximas_M(idx,:);
            nodelist(k).cost = nodelist(k).cost + matched(1);  
            nodelist(k).listSize = nodelist(k).listSize + 1;
            nodelist(k).iList(nodelist(k).listSize,:) = maxima_I;
            nodelist(k).mList(nodelist(k).listSize,:) = matched;  
            temp_M(idx) = 0;
            maximas_M(idx,:) = [0,-Inf];
            %temp_M = temp_M(temp_M>0);
        else
            break;
        end
    end
end

cost = nodelist(1).cost;
for m = 2:length(nodelist)
    if nodelist(m).cost < cost
       cost = nodelist(m).cost;
    end
end

a = 1;

end

