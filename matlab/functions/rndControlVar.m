% function file
% Author: Edward J. Xu
% Date: 190619
% ######################################################################################################################


function [z] = rndControlVar(vecPara)
    lambda = vecPara(1);
    c = vecPara(2);
    u = rand(1);
    x = 1 / lambda * exp(- 1 / lambda * u);
    y = u;
    z = x + c * (y - 0.5);
end
