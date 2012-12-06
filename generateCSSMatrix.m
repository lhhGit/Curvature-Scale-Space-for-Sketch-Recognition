function [ matrix ] = generateCSSMatrix( zero_crossings, pointCount )
%GENERATECSSMATRIX Summary of this function goes here
%   Detailed explanation goes here
sigmaCount = length(zero_crossings);
matrix = zeros(sigmaCount,pointCount);

for i = 1 : sigmaCount    
    inflexList = zero_crossings{i};
    if ~isempty(inflexList)
    matrix(inflexList(:,1),inflexList(:,2)) = 1;
    end
end

end

