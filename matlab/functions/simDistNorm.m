% function file
% Author: Edward J. Xu
% Date: 190619
% ######################################################################################################################


function [x] = simDistNorm(u, vecPara)
% Simulate one observation in standard normal distribution
    u1 = u(1);
    u2 = u(2);
    x = sqrt(-2 * log(u1)) * u2;
end
