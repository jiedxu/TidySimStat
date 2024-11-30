% function file
% Author: Edward J. Xu
% Date: 190619
% ######################################################################################################################


function [lbMean, ubMean] = analyzeVec(vecResult, strResult)
    fprintf('--------------------------------------------------------------------------------\n');
    fprintf(['Analysis of ' strResult ': \n'])
    fprintf('    mean = %f ; \n', mean(vecResult))
    fprintf('    median = %f ; \n', median(vecResult))
    fprintf('    variance = %f ; \n', var(vecResult))
    [lbMean, ubMean] = calInterConf(vecResult, 0.05);
end
