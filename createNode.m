function [ node ] = createNode( maxima_I,maxima_M )
%CREATENODE Summary of this function goes here
%   Detailed explanation goes here
n = 20;
node.iList = zeros(n,2);
node.mList = zeros(n,2);
node.iList(1,:) = maxima_I;
node.mList(1,:) = maxima_M;
node.shift = abs(maxima_I(1) - maxima_M(1));
node.cost = abs(maxima_I(2) - maxima_M(2));
end

