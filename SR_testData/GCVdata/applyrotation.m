function [ output ] = applyrotation( figure, degree )
%APPLYROTATION Apply rotation to a figure
%   figure m*2 matrix, each row stands for a coord
%   degree how much degree of rotation to apply

rad = degree*1.0/180*pi;
output = zeros(size(figure));
center = mean(figure,1);
for i = 1:length(figure)
    point = figure(i,:);
    vector = point - center;
    mod = sqrt(vector(1)^2 + vector(2)^2);
    sin_orig = vector(2)./mod;
    cos_orig = vector(1)./mod;
    sin_after = sin_orig*cos(rad) + sin(rad)*cos_orig;
    cos_after = cos_orig*cos(rad) - sin_orig*sin(rad);
    vector_after = [mod*cos_after, mod*sin_after];
    output(i,:) = center+ vector_after;
end


end

