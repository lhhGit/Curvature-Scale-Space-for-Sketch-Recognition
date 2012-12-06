function [ dist ] = computeDisp( P2,P1,P0 )
%COMPUTEDISP compute the minimum distance between a point and a line
%   P2 the point
%   P1,P0 the points by which the line is specified
%   P1,P2,P0 are all 2*1 matrix
if P1(1) ~= P0(1) 
numerator = abs( P2(1)*P1(2) - P1(1)*P2(2) + P0(1)*P2(2) - P2(1)*P0(2) + ...
                 P1(1)*P0(2) - P0(1)*P1(2) );

denominator = sqrt(sum((P1(2)-P0(2)).^2) + sum((P1(1)-P0(1)).^2));

dist = 1.0*numerator/denominator;
else
dist = abs(P2(1) - P0(1));    
end
end

