% function file
% Author: Edward J. Xu
% Date: 190619
% ######################################################################################################################


function doExercise_5(nSample)
    fprintf('--------------------------------------------------------------------------------\n');
    fprintf('Analytical Result: \n');
    fprintf('    value = %f ; \n', exp(1) - 1)
    for i = 1:4
        doExercise(i, nSample)
    end
end


function doExercise(whiFunc, nSample)
    fprintf('--------------------------------------------------------------------------------\n');
    fprintf('Simulation Result: \n')
    fprintf('    nSample = %d ; \n', nSample)
    vecU = rand(nSample, 1);
    tic
    [funcSim, vecU] = getFunc(whiFunc, vecU);
    vecResult = sampleFuncSim(nSample, funcSim, vecU);
    toc
    analyzeVec(vecResult, 'Simulation Result');
end


function [funcSim, vecU] = getFunc(whiFunc, vecU)
% To get the function
    if whiFunc == 1
        funcSim = @exp;
        strWhiFunc = 'crude exp';
    elseif whiFunc == 2
        funcSim = @(u) (exp(u) + exp(1-u)) / 2;
        strWhiFunc = 'antithetic';
    elseif whiFunc == 3
        c = - (mean(vecU .* exp(vecU)) - mean(vecU) * mean(exp(vecU))) / var(vecU);
        funcSim = @(u) exp(u) + c * (u - 0.5);  % mean(vecU)
        strWhiFunc = 'control variate';
    elseif whiFunc == 4
        matU = rand(length(vecU), 10);
        for i = 1:length(matU(:, 1))
            w_i = 0;
            for j = 1:10
                w_i = w_i + exp((j - 1 + matU(i, j)) / 10);
            end
            vecU(i) = w_i / 10;
        end
        funcSim = @(w) w;
        strWhiFunc =  'stratified';
    end
    fprintf('    method is %s ; \n', strWhiFunc);
end


function [vecResult] = sampleFuncSim(nSample, funcSim, vecU)
% To sample using the function
    vecResult = zeros(nSample, 1);
    for i = 1:nSample
        vecResult(i) = funcSim(vecU(i));
    end
end


function [vecResult] = sampleStratify(nSample, funcSim, vecU)
    vecResult = zeros(nSample, 1);
    for i = 1:nSample
        vecResult(i) = funcSim(vecU(i), i, nSample);
    end
end
