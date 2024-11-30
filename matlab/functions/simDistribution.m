% function file
% Author: Edward J. Xu
% Date: 190619
% ######################################################################################################################


function [vecXx] = simDistribution(cellUu, seed, funcSimDist, vecPara, strDist)
    rng(seed);
    nUu = length(cellUu);
    vecXx = zeros(nUu, 1);
    for i = 1:nUu
        vecXx(i) = funcSimDist(cellUu{i}, vecPara);
    end
    analyzeVec(vecXx, ['Simulated ' strDist ' Distribution']);
end
