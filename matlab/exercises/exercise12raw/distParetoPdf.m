function [ vecX, vecProbClass ] = distParetoPdf( vecU, beta, k, numClass, strFigName )
    numU = length(vecU);
    vecX = zeros(numU, 1);
    for i = 1:numU
        vecX(i) = beta * (vecU(i)^(- 1 / k) - 1);
    end
    vecXstd = [min(vecX):0.01:max(vecX)];
    vecYstd = gppdf(vecXstd, 1 / k, beta / k, 0);
    vecXdiff = vecX + beta;
    expect = mean(vecXdiff);
    expectCal = beta * k / (k - 1);
    var = mean(vecXdiff.^2) + expect^2;
    varCal = beta^2 * k / (k - 1)^2 / (k - 2);
    fprintf("When beta = %f, k = %f.\n", beta, k)
    fprintf("Expect = %f, theoretically = %f.\n", expect, expectCal)
    fprintf("Variance = %f, theoretically = %f.\n", var, varCal)
    [vecProbClass] = plotHist(vecX, vecXstd, vecYstd, numClass, strFigName);
end
