function [ output ] = findCandidates( cordList, min, ratio )
%FINDCANDIDATES find coordinates in cordList whose Y value(column 1) are
%greater than min
idx = cordList(:,1) > min * ratio;
output = cordList(idx,:);


end

