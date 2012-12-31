function [ value ] = safeGet( list, start_idx, end_idx)
%SAFEGET Summary of this function goes here
%   Detailed explanation goes here
if (start_idx > 0 && end_idx <= length(list))
    value = list(start_idx:end_idx);
else if (start_idx <=0)
      value = [list(start_idx+length(list):length(list)) ...
          ;list(1:end_idx)];
     else
      value = [list(start_idx:length(list)); ...
      list(1:end_idx-length(list))];
     end
 
end

