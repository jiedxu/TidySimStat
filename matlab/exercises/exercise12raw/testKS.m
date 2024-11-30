
function [ vecCumulatedNorm ] = testKS(vecResult, max)
    vecCumulated = zeros(max + 1, 1);  % starts from 0
    for i = 1:max
        % numInt(1:x) = 0
        x = vecResult(i);
        vecCumulated((x + 1):max) = vecCumulated((x + 1):max) + 1;
    end
    numObs = length(vecResult);
    vecCumulatedNorm = vecCumulated / numObs;
end

x = [0:.01:1];
y = normcdf(x, 1/10000, 1e-4 * (1 - 1e-4) / 10000);
plot(x, y)

% function [ out ] = function(vecResult, vecMinMax)
%     min = vecMinMax(1)
%     max = vecMinMax(2)m
%     numInt = max - min + 1
%     vecCumulated = zeros(numInt, 1)
%     for i in vecResult
%         numInt(1:(min + (x - min) + 1)) = 0
%         numInt(x:) = 0
%     end
% end  % function
