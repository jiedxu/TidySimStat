% function file
% Author: Edward J. Xu
% Date: 190619
% ######################################################################################################################


function testKS(vecXx, vecTest, whiTail)
    fprintf('Perform Sample-StdSample Kolmogorov-Smirnov Test: \n')
    if whiTail
        [h, pValue] = kstest2(vecXx, vecTest, 'Alpha', 0.05, 'Tail', 'larger');
    else
        [h, pValue] = kstest2(vecXx, vecTest, 'Alpha', 0.05);
    end
    % h = lillietest(vecXx, 'Alpha', 0.05, 'Distribution', strDist);
    if h == 1
        fprintf('    Reject the null hypothesis at the alpha = 0.05 significance level.\n')
    elseif h == 0
        fprintf('    Accept the null hypothesis at the alpha = 0.05 significance level.\n')
    end
    fprintf('    pValue = %f ; \n', pValue);
end
