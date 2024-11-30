% Simulated Annealing to Optimize in Sample Space
% Author: Edward J. Xu
% Date: 190614
% ######################################################################################################################


function [sState] = simAnnealing(startPosition, m, nSample, matCost, tempMax, coefDecay, seedInitial, coefStretch)
    %
    % vecTemp = zeros(nSample, 1);
    % for i = 1:nSample
    %     vecTemp(i) = calTemp(i, tempMax, coefDecay, coefStretch) * (5000 / tempMax);
    % end
    % plot(1:nSample, vecTemp);
    %% Get the sample space
    cass = getCellArraySampleSpaceAnnealing(m, startPosition);  % cass: cellArraySampleSpace
    %% Generate a Permutation Randomly
    vecXx = zeros(m + 1, 1);
    vecXx(1) = startPosition;
    vecXx(m + 1) = startPosition;
    rng(seedInitial);
    vecPerm = randperm(m);
    vecXx(2:m) = vecPerm(vecPerm ~= startPosition);
    %% Initialize the struct
    sState(1:nSample) = struct('x', zeros(m + 1, 1), 'y', zeros(m + 1, 1), 'z', zeros(2, 1), 'temp', 0, 'obj', 0);
    % sState(1).x = [1, 13, 4, 3, 18, 17, 11, 7, 20, 9, 14, 19, 5, 8, 16, 10, 15, 2, 12, 6, 1];
    % sState(1).y = [1, 13, 4, 3, 18, 17, 11, 7, 20, 9, 14, 19, 5, 8, 16, 10, 15, 2, 12, 6, 1];
    sState(1).x = vecXx + 0;
    sState(1).y = vecXx + 0;
    sState(1).z = cass{randi(length(cass))};
    sState(1).temp = calTemp(1, tempMax, coefDecay, coefStretch);
    sState(1).obj = calEnergy(sState(1).x, matCost);
    %% Lauch the live plot
    % x = 1;
    % y = sState(1).obj;
    % figure
    % fig = plot(x, y);
    % linkdata on
    % xlim([1 nSample])
    % ylim([0 5000])
    % xlabel('Iteration')
    % ylabel('Approximation for \pi')
    % fig.XDataSource = 'x';
    % fig.YDataSource = 'y';
    %% Start Anealing
    for n = 2:nSample
        sState(n).z = loopRandWalk2dim(cass, sState(n - 1).z);
        sState(n).y = sState(n - 1).y;
        % sState(n).y(sState(n).z(1)) = sState(n - 1).y(sState(n).z(2));
        % sState(n).y(sState(n).z(2)) = sState(n - 1).y(sState(n).z(1));
        %% Flip the path between generated change
        left = min(sState(n).z(1), sState(n).z(2));
        right = max(sState(n).z(1), sState(n).z(2));
        sState(n).y(left:right) = flipud(sState(n).y(left:right));
        %% Accept the candidate state or not.
        sState(n).temp = calTemp(n, tempMax, coefDecay, coefStretch);
        [sState(n).x, sState(n).accept] = acceptCandidate(sState(n - 1).x, sState(n).y, sState(n).temp, matCost);
        if sState(n).accept == 0
            sState(n).z = sState(n - 1).z;
        end
        sState(n).obj = calEnergy(sState(n).x, matCost);
        %% Update the live plot
        % x = n;
        % y = sState(n).obj;
        % refreshdata
        % plot(x, y);
    end
end


function [x, accept] = acceptCandidate(xPre, y, temp, matCost)
    if calEnergy(y, matCost) < calEnergy(xPre, matCost)
        x = y;
        accept = 1;
    else
        if rand() < exp(getCountAnnealing(y, temp, matCost) / getCountAnnealing(xPre, temp, matCost))
            x = y;
            accept = 1;
        else
            x = xPre;
            accept = 0;
        end
    end
end


function [cass] = getCellArraySampleSpaceAnnealing(m, startPosition)
    %
    vecPossible = 1:m;
    vecPossible = vecPossible(1:m ~= startPosition);
    % Get the sample space in one dimension
    vecData1 = vecPossible;
    vecData2 = vecPossible;
    n1 = length(vecPossible);
    n2 = length(vecPossible);
    funcLogic = @(data1, data2) data1 ~= data2;  % vecPossible(i) ~= vecPossible(j)
    cellSampleSpace = getCellSampleSpace2dim(vecData1, vecData2, n1, n2, funcLogic);
    %
    nRow = length(vecPossible);
    cass = getCellArraySampleSpace(cellSampleSpace, nRow);
end


function [count] = getCountAnnealing(vector, temp, matCost)
    energy = calEnergy(vector, matCost);
    count = exp(- energy / temp);
end


function [temp] = calTemp(k, tempMax, coefDecay, coefStretch)
    temp = tempMax / (1 + coefStretch * k)^coefDecay;
end
