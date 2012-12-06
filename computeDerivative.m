function [ derivatives ] = computeDerivative( order, valueList )
%COMPUTEFIRSTORDERDERIVATIVE 
%compute the first order derivatives of a point list
%  set the derivative of the start point to be zero
%  valueList  given list of points on a dimension
derivatives = zeros(size(valueList));
prev = valueList;
while order>0
for i = 2:length(prev)
    derivatives(i) = prev(i)-prev(i-1);
end
derivatives(1) = derivatives(2);
order = order -1;
prev = derivatives;
end

end

