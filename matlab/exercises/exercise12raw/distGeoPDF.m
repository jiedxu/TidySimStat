function [ vecX, vecProbClass ] = distGeoPDF(vecU, p, numClass, strFigName)
    numU = length(vecU);
    vecX = zeros(numU, 1);
    for i = 1:numU
        vecX(i) = floor(log(vecU(i)) / log(1 - p)) + 1;
    end
    
    % [vecProbClass] = plotHist(vecX, numClass, strFigName);
end
