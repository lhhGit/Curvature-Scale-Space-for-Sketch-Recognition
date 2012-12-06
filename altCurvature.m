function [ curvature ] = altCurvature( pointList , K)
%ALTCURVATURE Summary of this function goes here
%   Detailed explanation goes here
%   K extending size 

% extend the pointList
extended = [repmat(pointList(1,:),K,1);pointList;...
    repmat(pointList(end,:),K,1)];
curvature = zeros(length(pointList),1);
for i = 1 : length(pointList)
    result = (extended(i,:)'-extended(i+2*K,:)').^2;
    denominator = sqrt(sum(result)); 
    
    numerator = 0;
    for j = i : i+2*K
        numerator = numerator + computeDisp(extended(j,:)',...
            extended(i,:)',extended(i+2*K,:)');
    end 
    curvature(i) = 1.0*numerator ./ denominator;
end

end

