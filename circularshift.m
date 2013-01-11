function [ output ] = circularshift( input, offset)
%CIRCULARSHIFT shift matrix's columns by offset dimension
%   Detailed explanation goes here
rows = size(input,1);
cols = size(input,2);
output = zeros(rows,cols);
for i = 1:cols
    if(i+offset<=cols)
        output(:,i) = input(:,i+offset);
    else
        output(:,i) = input(:,i+offset - cols);
    end
end

end

