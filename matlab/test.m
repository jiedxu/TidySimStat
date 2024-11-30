% test file for stochastic simulation
% Author: Edward J. Xu
% Date: 190616
% ######################################################################################################################
% cd ~/Documents/GitHub/StochasticSim
% pwd
addpath("~/Documents/GitHub/StochasticSim/functions")  % ###############################################################
addpath("~/Documents/GitHub/StochasticSim/exercises")  % ###############################################################
% 1,  Array the 2-D Irregular Sample Space for 8-Direction Random Walk
testRandomWalk2dim()


function testRandomWalk2dim()
    m = 10;
    nRow = 6;
    nSample = 100000;
    vecData1 = [0:1:m];
    vecData2 = [0:1:m];
    n1 = length(vecData1);
    n2 = length(vecData2);
    funcLogic = @(data1, data2) ((0 <= data1 + data2) & (data1 + data2 <= m));
    % Get `cellArraySSpace`
    cellSampleSpace = getCellSampleSpace2dim(vecData1, vecData2, n1, n2, funcLogic);
    cellArraySSpace = arrangeSampleSpace2dim(cellSampleSpace, nRow);
    % Simulation
    sState_1(1).x = cellArraySSpace{randi(length(cellArraySSpace))};
    sState_2(1).x = cellArraySSpace{randi(length(cellArraySSpace))};
    for i = 2:nSample
        sState_1(i).x = loopRandWalk2dim(cellArraySSpace, sState_1(i - 1).x);
        sState_2(i).x = loopRandWalk2dimStepByStep(m, sState_2(i - 1).x);
    end
    % Plot the final result
    vecX1_1 = zeros(nSample, 1);
    vecX2_1 = zeros(nSample, 1);
    vecX1_2 = zeros(nSample, 1);
    vecX2_2 = zeros(nSample, 1);
    for i = 1:nSample
        vecX1_1(i) = sState_1(i).x(1);
        vecX2_1(i) = sState_1(i).x(2);
        vecX1_2(i) = sState_2(i).x(1);
        vecX2_2(i) = sState_2(i).x(2);
    end
    plotHistgram2dimRaw(vecX1_1, vecX2_1, m, 'RandWalk2dim_1');
    plotHistgram2dimRaw(vecX1_2, vecX2_2, m, 'RandWalk2dim_2');
end


function [x] = loopRandWalk2dimStepByStep(m, xPre)
    x1 = loopRandWalk(xPre(1), m, 0);
    x2 = loopRandWalk(xPre(2), m - x1, 0);
    x = [x1, x2];
end


function [ fig ] = plotHistgram2dimRaw(vecX1, vecX2, m, strFileName)
    % Plot the histogram of RNG result and return the vector of values
    fig = figure("Visible", "off");
    fig = histogram2(vecX1, vecX2, [-0.5:1:(m + 0.5)], [-0.5:1:(m + 0.5)], 'FaceColor', 'flat');
    saveas(fig, [pwd '/images/test/', strFileName, '.png']);
    saveas(fig, [pwd '/images/test/', strFileName, '.fig']);
end
