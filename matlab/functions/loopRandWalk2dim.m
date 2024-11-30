% function file
% Author: Edward J. Xu
% Date: 190619
% ######################################################################################################################


function [vecCandidate] = loopRandWalk2dim(cass, vecPre)

% cass: cellArraySampleSpace
    [m, n] = size(cass);
    % Find where vecPre is
    where = 1;
    while ~isequal(cass{where}, vecPre)
        where = where + 1;
    end
    [x, y] = getArrayPosition(where, m, n);
    % disp(x)
    % disp(y)
    if cass{x, y} ~= cass{where}
        error('Error when trying to find where the x is.')
    end
    % Random Walk
    x = loopRandWalk(x, m, 1);
    y = loopRandWalk(y, n, 1);
    % disp(x)
    % disp(y)
    vecCandidate = [cass{x, y}];
end
