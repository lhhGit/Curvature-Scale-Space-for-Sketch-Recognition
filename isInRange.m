function [ isIn ] = isInRange( input, startP, endP, size )
%ISINRANGE check if the input point is in range of startP and endP, both
%startP and endP can be negative
%   Detailed explanation goes here
% first set the startP and endP to positive and below size
while(startP<=0)
    startP = startP + size; 
end
while(startP>size)
    startP = startP - size; 
end   
while(endP<=0)
    endP = endP + size; 
end
while(endP>size)
    endP = endP - size; 
end
if (startP < endP)
    isIn = input>=startP && input<=endP;
else
    isIn = input>=startP || input<=endP;

end

