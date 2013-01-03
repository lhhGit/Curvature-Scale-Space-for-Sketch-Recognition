function [ cost ] = matchingAlgo( CSS_I, CSS_M )
%MATCHINGALGO Summary of this function goes here
%   Detailed explanation goes here
cost1 = matching(CSS_I, CSS_M);
cost2 = matching(CSS_M, CSS_I);

if cost1 > cost2
   cost = cost2;
else
   cost = cost1;
end

end

