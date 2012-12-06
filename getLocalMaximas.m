function [ idx ] = getLocalMaximas( list, window, thresh )
%GETLOCALMAXIMAS Summary of this function goes here
%   Detailed explanation goes here
%assume window size is odd, list is column vector
len = length(list);
ext_list = [ones((window-1)/2,1)*list(1);list;ones((window-1)/2,1)*list(end)];
idx = zeros(len,2);
for i = 1 : len 
    temp = [ext_list(i:i+(window-1)/2-1);ext_list(i+(window-1)/2+1:i+window-1)];
    if max(abs(temp)) < abs(list(i)) && abs(list(i)) > thresh
        idx(i,1) = 1;
        idx(i,2) = list(i);
    end
end

%cand_idxs = find(idx(:,1)==1);
%candidates = idx(idx(:,1) == 1,:);
%diff = computeDerivative(1,candidates(:,2));
%indices = diff <= 0.01;
%idx(cand_idxs(indices),1) = 0;

