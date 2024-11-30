function [ vecResult, prob ] = testRngLcg(mCap, a, c, x0, strFigName)
    % Test the simulated random number using many test
    % Example: mCap = 16; a = 5; c = 1; x0 = 3;
    %          vecResult = function(mCap, a, c, x0)
    % 1,  Generate the vector of random numbers using LCG
    [vecResult, vecProb] = getRngLcg(mCap, a, c, x0);
    % 2,  Plot the histogram of normlized number using 0 as min and mCap as max
    [vecProbClass] = plotHist(vecResult, 10, strFigName);
    % 3,  Test
    [prob] = testChiSquare(vecProbClass);
    fprintf('Chi-Square Test Result: %f. \n', prob)
end
