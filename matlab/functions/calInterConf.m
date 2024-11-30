% function file for exercise 4
% Author: Edward J. Xu
% Date: 190611
% ######################################################################################################################


function [lbMean, ubMean] = calInterConf(vecResult, alpha)
% Calculate the Confidence Interval of vecResult
% default: alpha = 0.05
% ub: upper bound ; lb: lower bound ;
    n = length(vecResult);
    expect = mean(vecResult);
    % se = sqrt(sum((vecResult - expect).^2) / (n - 1));
    se = (sum(vecResult.^2) - n * expect^2) / (n - 1);  % equation from the slides
    lbMean = expect - se * tinv(1 - alpha / 2, n - 1) / sqrt(n);
    ubMean = expect + se * tinv(1 - alpha / 2, n - 1) / sqrt(n);
    fprintf('    ubMean = %f ;\n', ubMean)
    fprintf('    lbMean = %f ;\n', lbMean)
    lbVar = sqrt((n - 1) * se^2 / chi2inv(1 - alpha / 2, n - 1));
    ubVar = sqrt((n - 1) * se^2 / chi2inv(alpha / 2, n - 1));
    fprintf('    ubVar = %f ;\n', ubVar)
    fprintf('    lbVar = %f ;\n', lbVar)
end
