function [ cordList ] = generateCSSCordList( zero_crossings)
%GENERATECSSMATRIX Summary of this function goes here
%   Detailed explanation goes here
sigmaCount = length(zero_crossings);
% total number of zero_crossings
count = 0;
for i = 1 : sigmaCount
    count = count + size(zero_crossings{i},1);
end

cordList = zeros(count,2);

pointer = 1;
for i = 1 : sigmaCount    
    inflexList = zero_crossings{i};
    rows = size(inflexList,1);    
    cordList(pointer:pointer+rows-1,:) = inflexList;
    pointer = pointer + rows;
end

end

