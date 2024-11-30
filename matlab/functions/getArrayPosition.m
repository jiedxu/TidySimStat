% function file
% Author: Edward J. Xu
% Date: 190619
% ######################################################################################################################


function [x, y] = getArrayPosition(where, m, n)
    x = mod(where, m);
    y = floor(where / m) + 1;
    if x == 0
        x = m;
        y = y - 1;
    end
end
