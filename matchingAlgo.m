function [ cost ] = matchingAlgo( CSS_I, CSS_M )
%MATCHINGALGO Summary of this function goes here
%   Detailed explanation goes here
cost1 = matchingV2(CSS_I, CSS_M);
cost2 = matchingV2(CSS_M, CSS_I);

if cost1 > cost2
   cost = cost2;
else
   cost = cost1;
end

%cost = (cost1 + cost2)/2.0;
end

