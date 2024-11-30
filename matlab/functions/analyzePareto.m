% function file
% Author: Edward J. Xu
% Date: 190619
% ######################################################################################################################


function [meanDist] = analyzePareto(beta, k)
    meanDist = beta * k / (k - 1);
    medianDist = beta * 2^(1 / k);
    varDist = beta^2 * k / (k - 1)^2 / (k - 2);
    strDist = 'Pareto';
    fprintf(['Theoretical Result of ' strDist ': \n'])
    fprintf('    beta = %f ; \n', beta)
    fprintf('    k = %f ; \n', k)
    fprintf('    mean = %f ; \n', meanDist)
    fprintf('    median = %f ; \n', medianDist)
    if k < 2
        fprintf('    We cannot get variance of Pareto dist theoretically when beta < 2; \n')
    else
        fprintf('    variance = %f ; \n', varDist)
    end
end
