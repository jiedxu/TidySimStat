

function [x] = simDistExp(u, vecPara)
    lambda = vecPara(1);
    x = - log(u) / lambda;
end
