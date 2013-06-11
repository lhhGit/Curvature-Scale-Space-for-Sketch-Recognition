function [ expanded_node ] = expandNode( node, extremas_I, extremas_M )
%EXPANDNODE Summary of this function goes here
%   Detailed explanation goes here
unmatched_I = setdiff(extremas_I, node.iList, 'rows');
unmatched_M = setdiff(extremas_M, node.mList, 'rows');
half_range = 40;
total_size = 200;
if(~isempty(unmatched_I))
    [~,I] = max(unmatched_I(:,1));
    current_extrema_I = unmatched_I(I,:);
    shift = node.shift;
    pivot = current_extrema_I(1,2) + shift;
    if(~isempty(unmatched_M))
        minV = min(abs(unmatched_M(:,2) - pivot));
        idx = abs(unmatched_M(:,2) - pivot) == minV;
        matched = unmatched_M(idx,:);
        if(size(matched,1) > 1)
            [~,max_idx] = max(matched(:,1));
            matched = matched(max_idx,:);
        end
        if isInRange(matched(2),pivot-half_range,pivot+half_range,total_size)
           %update cost
           node.cost = node.cost + abs(matched(1) - current_extrema_I(1));        
        else
           node.cost = node.cost + current_extrema_I(1); 
        end
        node.listSize = node.listSize + 1;
        node.iList = [node.iList;current_extrema_I];
        node.mList = [node.mList;matched];
    else
        node.cost = node.cost + current_extrema_I(1);
        node.listSize = node.listSize + 1;
        node.iList = [node.iList;current_extrema_I];
    end
else
    if(isempty(unmatched_M))
        expanded_node = node;
        return
    else
        [~,I] = max(unmatched_M(:,1));
        matched = unmatched_M(I,:);
        node.cost = node.cost + matched(1);  
        node.listSize = node.listSize + 1;
        node.mList = [node.mList;matched];
    end
end
expanded_node = node;
end

