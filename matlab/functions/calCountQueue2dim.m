% function file
% Author: Edward J. Xu
% Date: 190619
% ######################################################################################################################


function [b] = calCountQueue2dim(i, j, aCap_1, aCap_2)
    b = aCap_1^i / factorial(i) * aCap_2^j / factorial(j);
end
