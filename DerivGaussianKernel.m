function [ kernel ] = DerivGaussianKernel( size, sigma, order)
%DERIVGAUSSIANKERNEL generate derivative of 1D gaussian kernel
%   size kernel size
%   sigma the sigma parameter in the gaussian expression
%   order the order of derivative
dist = (-(size-1)/2 :(size-1)/2)';
%if sigma == 0
%   kernel = [zeros((size-1)/2,1);1;zeros((size-1)/2,1)];
%   return
%end
zero_order = 1/(sqrt(2*pi)*sigma)*exp(-dist.^2/(2*sigma^2));
weight = 1.0/sum(zero_order);
switch order
    case 0
        kernel = weight*zero_order;
       
    case 1
        kernel = (-dist/(sqrt(2*pi)*sigma^3)).*exp(-dist.^2/(2*sigma^2));
        
    case 2
        kernel = 1/(sqrt(2*pi)*sigma)*exp(-dist.^2/(2*sigma^2)).*...
            (dist.^2/sigma^2-1);
end
end

