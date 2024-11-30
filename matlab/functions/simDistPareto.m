% function file
% Author: Edward J. Xu
% Date: 190619
% ######################################################################################################################


function [x] = simDistPareto(u, vecPara)
% vecPara = [beta, k];
    beta = vecPara(1);
    k = vecPara(2);
    xRaw = beta * (u^(- 1 / k) - 1);
    x = xRaw + beta;
end
