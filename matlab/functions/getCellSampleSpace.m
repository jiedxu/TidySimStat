% function file
% Author: Edward J. Xu
% Date: 190619
% ######################################################################################################################


function [cellSampleSpace] = getCellSampleSpace(vecSampleSpace)
    n = length(vecSampleSpace);
    cellSampleSpace = cell(n, 1);
    for i = 1:n
        cellSampleSpace{i} = vecSampleSpace(i);
    end
end
