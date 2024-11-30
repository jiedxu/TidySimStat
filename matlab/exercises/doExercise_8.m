% function file
% Author: Edward J. Xu
% Date: 190619
% ######################################################################################################################


function doExercise_8(beta, k, nSet, nObs, seedObs)
    fprintf('--------------------------------------------------------------------------------\n');
    fprintf('Set Parameters: \n')
    fprintf('    beta = %f ; \n', beta)
    fprintf('    k = %f ; \n', k)
    fprintf('    nObs = %d ; \n', nObs)
    vecPara = [beta, k];
    % 2, Generate Observations
    funcSimDist = @simDistPareto;
    vecUu = rand(nObs, 1);
    cellUu = num2cell(vecUu);
    vecXx = simDistribution(cellUu, seedObs, funcSimDist, vecPara, 'Pareto');
    % 3, Bootstrap Data Sets
    % sample from observations set with replacement
    [matBootstrap] = simBootstrap(vecXx, nSet);
    fprintf('--------------------------------------------------------------------------------\n');
    fprintf('Theoretically: \n')
    fprintf('    mean = %f ; \n', beta * k / (k - 1))
    fprintf('    median = %f ; \n', beta * 2^(1 / k))
    variance = beta^2 * k / (k - 1)^2 / (k - 2);
    if variance >= 0
        fprintf('    variance = %f ; \n', variance)
    else
        fprintf('    We cannot get theoretical value for variance ; \n')
    end
end
