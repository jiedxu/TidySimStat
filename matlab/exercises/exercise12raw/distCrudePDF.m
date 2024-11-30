function [ vecX, vecProbClass ] = distCrudePDF( vecU, vecValue, strFigName )
    numU = length(vecU);
    vecX = zeros(numU, 1);
    numValue = length(vecValue)
    for i = 1:numU
        j = 2;
        while ~((vecU(i) > vecValue(j - 1)) & (vecU(i) <= vecValue(j)))
            j = j + 1;
        end
        vecX(i) = vecValue(j);
    end
    [vecProbClass] = plotHist(vecX, numValue, strFigName);
end  % function
