function [ cost ] = matchingV2( CSS_I, CSS_M )
%MATCHING Matching algorithm of two CSS images
%   cost   The matching cost
%   CSS_I, CSS_M   The two input CSS binary images, belongs to image and
%   model respectively
%   extract the extremas
[cord_I_y,cord_I_x] = find(CSS_I == 0);
[cord_M_y,cord_M_x] = find(CSS_M == 0);
cord_I = [cord_I_y,cord_I_x];
cord_M = [cord_M_y,cord_M_x];
extremas_I = extractMaxima(cord_I,CSS_I);
extremas_M = extractMaxima(cord_M,CSS_M);

if(size(extremas_M,1) == 0) 
    cost = abs(sum(extremas_I(:,1)) - sum(extremas_M(:,1)));
    return
end

if(size(extremas_I,1) < 2)
    cost = abs(extremas_I(1,1) - extremas_M(1,1));
    for k = 2:size(extremas_M,1) 
        cost = cost + extremas_M(k,1);
    end
    return
end

ratio = 0.8;
nodelist = struct('iList',[],'mList',[],'shift',[],'cost',[],'listSize',[]);
maximum_I = extremas_I(1,:);
secmaximum_I = extremas_I(2,:);
maximum_M = extremas_M(1,:);
node = createNode(maximum_I,maximum_M);
%append node to nodelist
nodelist(1) = node;
%find matching candidates for maximum, and create nodes accordingly
maximum_cds = findCandidates(extremas_M(2:end,:), maximum_I(1), ratio);
for i = 1:size(maximum_cds,1)
   nodelist(length(nodelist)+1) = createNode(maximum_I, maximum_cds(i,:));
end
%do the same for second largest maximum
secmaximum_cds = findCandidates(extremas_M, secmaximum_I(1), ratio);
for i = 1:size(secmaximum_cds,1)
   nodelist(length(nodelist)+1) = createNode(secmaximum_I, secmaximum_cds(i,:));
end

%expand each node
for i = 1:length(nodelist)
    %get unmatched extremas in the image
    nodelist(i) = expandNode(nodelist(i),extremas_I,extremas_M);
end

while(true)
    %select the lowest cost node 
    cost = nodelist(1).cost;
    node_index = 1;
    for i = 2:length(nodelist)
        if(nodelist(i).cost < cost)
            node_index = i;
            cost = nodelist(i).cost;
        end
    end
    lowest_node = nodelist(node_index);
    matched_I = lowest_node.iList;
    matched_M = lowest_node.mList;
    if(isempty(setdiff(extremas_I,matched_I,'rows'))&&...
       isempty(setdiff(extremas_M,matched_M,'rows')))
       break
    else
        nodelist(node_index) = expandNode(nodelist(node_index),...
        extremas_I,extremas_M);   
    end
end

cost = lowest_node.cost;
end

