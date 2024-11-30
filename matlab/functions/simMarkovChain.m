

function [sState] = simMarkovChain(sampleSpace, funcGetCandidate, funcAcceptCandidate, nSample, vecPara)
% Perform Markov Chain Monte Carlo Simulation
%
% author: Edward J. Xu
% date: 190622
    sState(1:nSample) = struct('x', NaN, 'accept', 0, 'y', NaN);
    sState(1).x = sampleSpace{randi(length(sampleSpace))};
    sState(1).y = funcGetCandidate(sampleSpace, sState(1).x);  % First y walked from the first x
    sState(1).accept = 1;
    for n = 2:nSample
        sState(n).y = funcGetCandidate(sampleSpace, sState(n - 1).x);
        % alternative algorithm: y is the random walking state, sState(n - 1).x can be different from sState(n - 1).y,
        % so we see y as the independent walking state
        cell = funcAcceptCandidate(sState(n - 1).x, sState(n).y, vecPara);
        sState(n).x = cell{1};
        sState(n).accept = cell{2};
    end
end
