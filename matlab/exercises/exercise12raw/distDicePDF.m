function [ vecX, vecProbClass ] = distDicePDF( vecU, numDice, strFigName )
    numU = length(vecU);
    vecX = zeros(numU, 1);
    for i = 1:numU
        vecX(i) = floor(numDice * vecU(i)) + 1;
    end
    [vecProbClass] = plotHist(vecX, numDice, strFigName);
end  % function
