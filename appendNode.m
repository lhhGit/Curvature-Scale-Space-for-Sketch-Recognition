function [ updatedList ] = appendNode( nodeList, node)
%APPENDNODE Summary of this function goes here
%   Detailed explanation goes here
if(~isempty(nodeList))
   len = length(nodeList);
   nodeList(len+1) = node; 
end

end

