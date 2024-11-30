% function file
% Author: Edward J. Xu
% Date: 190619
% ######################################################################################################################


function [cellSampleSpace] = getCellSampleSpace2dim(vecData1, vecData2, n1, n2, funcLogic)
    cellSampleSpaceRaw = cell(n1 * n2, 1);
    k = 1;
    for i = 1:n1
        for j = 1:n2
            if funcLogic(vecData1(i), vecData2(j))
                cellSampleSpaceRaw{k} = [vecData1(i), vecData2(j)];
                k = k + 1;
            end
        end
    end
    cellSampleSpace = cellSampleSpaceRaw(~cellfun('isempty', cellSampleSpaceRaw));
    cellSampleSpace = cellSampleSpace(randperm(length(cellSampleSpace)));
end
