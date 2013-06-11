function [ cost ] = matchingCustom( CSS_I, CSS_M )
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
if(len1 < 2||len2 < 2)
   if(len1 == 0||len2 == 0)
       cost = abs(sum(maximas_I(:,1)) - sum(maximas_M(:,1)));
       return
   end
   if(len1 < 2)
      smaller = maximas_I;
      greater = maximas_M;
   else
      smaller = maximas_M;
      greater = maximas_I;
   end
   
   cost = abs(max(greater(:,1)) - max(smaller(:,1)));
   if(size(greater,1) > 1)
       cost = cost + sum(greater(2:end,1));
       return
   else
       return
   end
   
end    
minValue = abs(maximas_I(1,1) - maximas_M(1,1));

unused_maximas_I = maximas_I;
unused_maximas_M = maximas_M;

%Image 最高点和次高点
maximum = maximas_I(1,:);
secMaximum = maximas_I(2,:);
costlog = [];
ratio = 0.8;
maximum_cds = findCandidates(unused_maximas_M, maximum, ratio);
%count for combination
pp = 0;
node_List = struct('iList',[],'mList',[],'shift',[],'cost',[],'listSize',[]);

for j = 1:size(maximum_cds,1)
    %initialize 
    current_max_matched = maximum_cds(j,:);
    node_List(1) = createNode(maximum,current_max_matched);
    firstnode = node_List(1);
    unused_maximas_I = removeItemFromList(unused_maximas_I,maximum);
    unused_maximas_M = removeItemFromList(unused_maximas_M,current_max_matched);
    %find candidates for the second largest image maximum
    secMaximum_cds = findCandidates(unused_maximas_M, secMaximum, ratio);
    for i = 1:size(secMaximum_cds,1)
    current_secmax_matched = secMaximum_cds(i);
    node_List(1) = firstnode;
    node_List(2) = createNode(secMaximum,current_secmax_matched);
    unused_maximas_I = removeItemFromList(unused_maximas_I,secMaximum);
    unused_maximas_M = removeItemFromList(unused_maximas_M,current_secmax_matched);
    %expand nodes 
    half_range = 0.2 * size(CSS_I,2);
    while(~isempty(unused_maximas_I) || ~isempty(unused_maximas_M))
    if(node_List(1).cost>node_List(2).cost)
        k = 2;
    else
        k = 1;
    end
    shift = node_List(k).shift;
    if ~isempty(unused_maximas_I)
        [~, index] = max(unused_maximas_I(:,1));
        current_maxima = unused_maximas_I(index,:);
        node_List(k).listSize = node_List(k).listSize + 1;
        node_List(k).iList(node_List(k).listSize,:) = current_maxima;
        % find the corresponding match in the model
        pivot = current_maxima(:,2) + shift;
        if ~isempty(unused_maximas_M)    
            [~,idx] = min(abs(unused_maximas_M(:,2) - pivot));
            matched = unused_maximas_M(idx,:);
            if isInRange(matched(2),pivot-half_range,pivot+half_range,size(CSS_I,2))
            %update cost
                node_List(k).cost = node_List(k).cost + abs(matched(1) - current_maxima(1));        
            else
                node_List(k).cost = node_List(k).cost + current_maxima(1); 
            end
            %update list      
            node_List(k).mList(node_List(k).listSize,:) = matched;
            unused_maximas_I = removeItemFromList(unused_maximas_I,current_maxima);
            unused_maximas_M = removeItemFromList(unused_maximas_M,matched);
        else
            %if there are no more maximums in the model
            node_List(k).cost = node_List(k).cost + current_maxima(1);
            unused_maximas_I = removeItemFromList(unused_maximas_I,current_maxima);
        end
    else
        %if there are no more maximums in the image
        if ~isempty(unused_maximas_M) 
            [~,idx] = max(temp_M);
            matched = maximas_M(idx,:);
            node_List(k).cost = node_List(k).cost + matched(1);  
            node_List(k).listSize = node_List(k).listSize + 1;
            node_List(k).mList(node_List(k).listSize,:) = matched;  
            temp_M(idx) = 0;
            maximas_M(idx,:) = [0,-Inf];
            %temp_M = temp_M(temp_M>0);
        else
            break;
        end
    end
end

for m = 1:length(node_List)
    disp('iList');
    disp([node_List(m).iList]);
    disp('mList');
    disp([node_List(m).mList]);
end

tempcost = node_List(1).cost;
for m = 2:length(node_List)
    if node_List(m).cost < tempcost
       tempcost = node_List(m).cost;
    end
end
%node_List

costlog(pp) = tempcost;
    
    node_List(2)=[];
    node_List(1) = firstnode;
    end
    node_List(1)=[];    
end


cost = min(costlog);

cost = max(cost,minValue);

end

