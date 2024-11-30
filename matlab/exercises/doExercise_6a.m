% function file
% Author: Edward J. Xu
% Date: 190619
% ######################################################################################################################


function doExercise_6a(m, nSample, aCap)
    % --------------------------------------------------------------------------------------
    cellSampleSpace = getCellSampleSpace(0:1:m);
    funcGetCandidate = @(css, xPre) loopRandWalk(xPre, css{end}, css{1});
    vecPara = aCap;
    funcAcceptCandidate = @accept;
    sState = simMarkovChain(cellSampleSpace, funcGetCandidate, funcAcceptCandidate, nSample, vecPara);
    vecState = [sState.x];
    save([pwd '/outputs/vecState_2.mat'], 'vecState');
    % Calculate the Analytical Values ----------------------------------------------------------------------------------
    vecProbExpect = zeros(m + 1, 1);
    for j = 0:m
        vecProbExpect(j + 1) = calCountQueue(j, aCap);
    end
    vecProbExpect = vecProbExpect / sum(vecProbExpect);
    % Plot the Histogram of the Result ---------------------------------------------------------------------------------
    strTitle = 'Simulation and Analysis Result of Queueing System with 10 Servers and A being 8';
    vecProbObs = plotHistogram(vecState(1000:end), 0:1:m, vecProbExpect, m + 1, strTitle, '6/6');
    % disp(vecObs * nSample)
    % disp(vecProbExpect * nSample)
    testChiSquare(vecProbObs * nSample, vecProbExpect * nSample, 0.05);
end


function [cell] = accept(xPre, y, vecPara)
    aCap = vecPara(1);
    if calCountQueue(y, aCap) >= calCountQueue(xPre, aCap)
        x = y;
        accept = 1;
    else
        if rand() < calCountQueue(y, aCap) / calCountQueue(xPre, aCap)
            x = y;
            accept = 1;
        else
            x = xPre;
            accept = 0;
        end
    end
    cell = {x, accept};
end
