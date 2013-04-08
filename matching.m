function [ cost ] = matching( CSS_I, CSS_M )
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


maximas_I_im = maximas_I;
maximas_M_im = maximas_M;
%   find the two largest values of the CSS image of image
temp_I = maximas_I(:,1); %copy of the maxima sigmas in the image, y coords
temp_M = maximas_M(:,1); %copy of the maxima sigmas in the model, y coords
% n = 100;

%candidates in the model that can match the image maximum as well as their
%index in maximas_M
maximum_candidates = zeros(0,3);
%candidates in the image that can match the image second maximum as well as their
%index in maximas_M
smaximum_candidates = zeros(0,3);

costlog = [];

[maxima_I_ini, idx_I_im] = max(temp_I);
maxima_I = maximas_I(idx_I_im,:);
indices = find(temp_M>=maxima_I_ini*0.8 & temp_M<=maxima_I_ini*1.25);
if(~isempty(indices))
    maximum_candidates = [maximas_M(indices,:), indices];
else
    [~, idx_M] = max(temp_M);
    maxima_M = maximas_M(idx_M,:);
    maximum_candidates = [maxima_M,idx_M];
end

%count for combination
pp = 0;

for j = 1:size(maximum_candidates,1)
    %initialize 
    i = 1;
    maximas_I = maximas_I_im;
    maximas_M = maximas_M_im;
    temp_I = maximas_I(:,1); %copy of the maxima sigmas in the image, y coords
    temp_M = maximas_M(:,1); %copy of the maxima sigmas in the model, y coords
    node_List = struct('iList',[],'mList',[],'shift',[],'cost',[],'listSize',[]);
    % mark the image maximum as used
    temp_I(idx_I_im) = 0;
    maximas_I(idx_I_im,:) = [0,-Inf];
    
    % the first two elements are coords, the third are index in temp_M
    maxima_M_currentInfo = maximum_candidates(j,:);
    node_List(i) = createNode(maxima_I,maxima_M_currentInfo(1:2));
    i = i + 1;
    %if added to node_List, then remove from the to-add list
    index = maxima_M_currentInfo(3);
    temp_M(index) = 0;
    maximas_M(index,:) = [0,-Inf];
    
    %create node for the second image maximum
    [maxima_I_ini, idx_I] = max(temp_I);
    maxima_I = maximas_I(idx_I,:);
    indices = find(temp_M>=maxima_I_ini*0.8 & temp_M<=maxima_I_ini*1.25);
    if(~isempty(indices))
        smaximum_candidates = [maximas_M(indices,:), indices];
    else
        [~, idx_M] = max(temp_M);
        maxima_M = maximas_M(idx_M,:);
        smaximum_candidates = [maxima_M,idx_M];
    end
    maximas_I_im_inloop = maximas_I;
    maximas_M_im_inloop = maximas_M;
    for tt = 1:size(smaximum_candidates,1)
    %initialize 
    pp = pp + 1;
    maximas_I = maximas_I_im_inloop;
    maximas_M = maximas_M_im_inloop;
    temp_I = maximas_I(:,1); %copy of the maxima sigmas in the image, y coords
    temp_M = maximas_M(:,1); %copy of the maxima sigmas in the model, y coords
    % mark the image second maximum as used
    temp_I(idx_I) = 0;
    maximas_I(idx_I,:) = [0,-Inf];
    maxima_M_currentInfo = smaximum_candidates(tt,:);
    node_List(i) = createNode(maxima_I,maxima_M_currentInfo(1:2));
    i = i + 1;
    %if added to node_List, then remove from the to-add list
    index = maxima_M_currentInfo(3);
    temp_M(index) = 0;
    maximas_M(index,:) = [0,-Inf];
    
    %expand nodes 
half_range = 0.2 * size(CSS_I,2);

while(~isempty(find(temp_I > 0, 1)) || ~isempty(find(temp_M > 0, 1)))
    % get the lowest cost node
    k = 1;
    cost = node_List(1).cost;
    for m = 2:length(node_List)
        if node_List(m).cost < cost
            k = m;
            cost = node_List(m).cost;
        end
    end
    shift = node_List(k).shift;
    if ~isempty(find(temp_I > 0,1))
        [maxima_I_y, idx_I] = max(temp_I);
        current_maxima = maximas_I(idx_I,:);
        temp_I(idx_I) = 0;
        maximas_I(idx_I,:) = [0,-Inf];
        %temp_I = temp_I(temp_I>0);
        % find the corresponding match in the model
        pivot = current_maxima(:,2) + shift;
        if ~isempty(find(temp_M > 0,1))    
            [dummy,idx] = min(abs(maximas_M(:,2) - pivot));
            matched = maximas_M(idx,:);
            if isInRange(matched(2),pivot-half_range,pivot+half_range,size(CSS_I,2))
            %update cost
                node_List(k).cost = node_List(k).cost + abs(matched(1) - current_maxima(1));        
            else
                node_List(k).cost = node_List(k).cost + current_maxima(1); 
            end
            %update list
            node_List(k).listSize = node_List(k).listSize + 1;
            node_List(k).iList(node_List(k).listSize,:) = current_maxima;
            node_List(k).mList(node_List(k).listSize,:) = matched;
            temp_M(idx) = 0;
            maximas_M(idx,:) = [0,-Inf];
            %temp_M = temp_M(temp_M>0);
        else
            %if there are no more maximums in the model
            node_List(k).cost = node_List(k).cost + current_maxima(1);
        end
    else
        %if there are no more maximums in the image
        if ~isempty(find(temp_M > 0,1)) 
            [dummy,idx] = max(temp_M);
            matched = maximas_M(idx,:);
            node_List(k).cost = node_List(k).cost + matched(1);  
            node_List(k).listSize = node_List(k).listSize + 1;
            node_List(k).iList(node_List(k).listSize,:) = maxima_I;
            node_List(k).mList(node_List(k).listSize,:) = matched;  
            temp_M(idx) = 0;
            maximas_M(idx,:) = [0,-Inf];
            %temp_M = temp_M(temp_M>0);
        else
            break;
        end
    end
end

tempcost = node_List(1).cost;
for m = 2:length(node_List)
    if node_List(m).cost < tempcost
       tempcost = node_List(m).cost;
    end
end


costlog(pp) = tempcost;

    end
    
end

cost = min(costlog);

end

