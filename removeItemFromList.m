function [ updated_list ] = removeItemFromList( list, item )
%REMOVEITEMFROMLIST Summary of this function goes here
%   Detailed explanation goes here
rows = find(list(:,1) == item(1) & list(:,1) == item(2));
if(isempty(rows))
    updated_list = list;
    disp('The item is not in the list');
elseif(length(rows) > 1)
    updated_list = list;
    disp('The list has duplicate records');
else
    list(rows,:) = [];
    updated_list = list;
end


end

