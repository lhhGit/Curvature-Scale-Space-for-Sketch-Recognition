function [ sampled ] = subSample( pointList, sp_size )
%SUBSAMPLE Summary of this function goes here
%   sp_size   number of sampled points
stepsize = size(pointList,1)/sp_size;
sampled = pointList(stepsize:stepsize:end,:);

end

