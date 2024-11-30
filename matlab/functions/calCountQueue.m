% function file
% Author: Edward J. Xu
% Date: 190619
% ######################################################################################################################


function [b] = calCountQueue(j, aCap)
    b = aCap^j / factorial(j);
end
