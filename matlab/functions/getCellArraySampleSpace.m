% function file
% Author: Edward J. Xu
% Date: 190619
% ######################################################################################################################


function [cass] = getCellArraySampleSpace(cellSampleSpace, nRow)
% cass: cellArraySampleSpace
    nCol = length(cellSampleSpace) / nRow;
    if mod(nCol, 1) ~= 0
        error('nRow is impossible!!!')
    end
    cass = cell(nRow, nCol);
    k = 1;
    for i = 1:nRow
        for j = 1:nCol
            cass(i, j) = cellSampleSpace(k);
            k = k + 1;
        end
    end
end
