% function file
% Author: Edward J. Xu
% Date: 190619
% ######################################################################################################################


function [matCount, matProbAnalysis, cass] = doExercise_6b(m, nRow, nSample, aCap_1, aCap_2, whiMethod)
    fprintf('nSample = %d ; \n', nSample)
    %
    vecAa = [aCap_1, aCap_2];
    if whiMethod == 1  % 2-D random walk directly
        funcGetCandidate = @loopRandWalk2dim;
        funcAcceptCandidate = @acceptCandidate;
    elseif whiMethod == 2  % Gibbs sampler
        funcGetCandidate = @(~, vecPre) sampleGibbs(vecPre, m, vecAa);
        % `cass` will not be used.
        funcAcceptCandidate = @(xPre, y, vecAa) {y, 1};
        % `xPre` and `vecAa` will not be used.
    elseif whiMethod == 3  % Column-wise random walk directly
        funcGetCandidate = @getCandidateCoWise;
        funcAcceptCandidate = @acceptCandidate;
    end
    cass = getSampleSpace2dim(m, nRow);
    sState2 = simMarkovChain(cass, funcGetCandidate, funcAcceptCandidate, nSample, vecAa);
    save([pwd '/outputs/6/sState2_4.mat'], 'sState2');
    % Calculate and Plot the Analytical Values
    matProbAnalysis = zeros(m + 1);
    for i = 0:m
        for j = 0:(m - i)
            matProbAnalysis(i + 1, j + 1) = calCountQueue2dim(...
                i, j, aCap_1, aCap_2);
        end
    end
    matProbAnalysis = matProbAnalysis / sum(sum(matProbAnalysis));
    % plotStem3(0:m, 0:m, matProbAnalysis, '/6/3');
    % Plot 3-D Histogram of the Result
    vecXx1 = zeros(nSample, 1);
    vecXx2 = zeros(nSample, 1);
    vecXx12 = zeros(nSample, 1);
    for i = 1:nSample
        vecXx1(i) = sState2(i).x(1);
        vecXx2(i) = sState2(i).x(2);
        vecXx12(i) = sum(sState2(i).x);
    end
    if sum(vecXx12 <= 10) ~= nSample
        error('There are some state(s) out of the state space.');
    end
    matCount = plotHistogram2dim(vecXx1, vecXx2, matProbAnalysis * nSample, m, '/6/2');
    % Perform Chi-Square Test
    doTestChiSquare(matCount, matProbAnalysis * nSample, 0.05, m)
end


function [cell] = acceptCandidate(xPre, y, vecAa)
    aCap_1 = vecAa(1);
    aCap_2 = vecAa(2);
    if calCountQueue2dim(y(1), y(2), aCap_1, aCap_2) >= calCountQueue2dim(xPre(1), xPre(2), aCap_1, aCap_2)
        x = y;
        accept = 1;
    else
        if rand() < (calCountQueue2dim(y(1), y(2), aCap_1, aCap_2) / calCountQueue2dim(xPre(1), xPre(2), aCap_1, aCap_2))
            x = y;
            accept = 1;
        else
            x = xPre;
            accept = 0;
        end
    end
    cell = {x, accept};
end


function [vecNow] = getCandidateCoWise(~, vecPre)
    vecNow = zeros(2, 1);
    i = randi(2, 1);
    if i == 1
        j = 2;
    else
        j = 1;
    end
    vecNow(j) = vecPre(j);
    vecNow(i) = loopRandWalk(vecPre(i), 10 - vecNow(j), 0);
end


function [vecCandidate] = sampleGibbs(vecPre, m, vecAa)
    vecCandidate = zeros(2, 1);

    % 1,  Draw i-coordinate to change
    i = randi(2);
    j = getOtherOne(i);
    vecCandidate(j) = vecPre(j);  % value j-coordinate remains the same

    % 2,  Define new random variable
    denominator = 0;
    for k = 0:1:(m - vecPre(j))
        denominator = denominator + calCountQueue(k, vecAa(j));
    end

    % 3,  Draw new value for j-coordinate from the new random variable
    draw = rand();
    k = 0;
    probCumu = calCountQueue(0, vecAa(j)) / denominator;
    while ~(draw < probCumu)
        k = k + 1;
        probCumu = probCumu + calCountQueue(k, vecAa(j)) / denominator;
    end
    
    if (k + vecCandidate(j)) > m
        error('i + j > m');
    elseif (k + vecCandidate(j)) < 0
        error('i + j < 0');
    end

    % 4,  Change
    vecCandidate(i) = k;
end


function [j] = getOtherOne(i)
    if i == 1
        j = 2;
    elseif i == 2
        j = 1;
    end
end


function [cass] = getSampleSpace2dim(m, nRow)
% cass: cellArraySampleSpace
% nRow = 6
    vecData1 = 0:1:m;
    vecData2 = 0:1:m;
    n1 = length(vecData1);
    n2 = length(vecData2);
    funcLogic = @(data1, data2) ((0 <= data1 + data2) & (data1 + data2 <= m));  % (0 <= i + j) & (i + j <= m)
    cellSampleSpace = getCellSampleSpace2dim(vecData1, vecData2, n1, n2, funcLogic);
    cass = getCellArraySampleSpace(cellSampleSpace, nRow);
end


function doTestChiSquare(matObs, matExp, alpha, m)
    vecObs = zeros((m + 1)^2, 1);
    vecExp = zeros((m + 1)^2, 1);
    for i = 1:(m + 1)^2
        vecObs(i) = matObs(i);
        vecExp(i) = matExp(i);
    end
    vecObs = vecObs(vecObs ~= 0);
    vecExp = vecExp(vecExp ~= 0);
    testChiSquare(vecObs, vecExp, alpha);
end
