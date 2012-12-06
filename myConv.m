function [ convlist ] = myConv( kernel, list )
%MYCONV Summary of this function goes here
%   Detailed explanation goes here
len = length(kernel);
convlist = zeros(length(list),1);
extended = [ones((len-1)/2,1)*list(1);list;ones((len-1)/2,1)*list(end)];
for i = 1 : length(list)
    convlist(i) = sum(extended(i:i+len-1).*kernel);
end

