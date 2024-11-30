% function file
% Author: Edward J. Xu
% Date: 190619
% ######################################################################################################################


function [matCount] = plotHistogram2dim(vecX1, vecX2, mat, m, strFileName)
    % Plot the histogram of RNG result and return the vector of values
    fig = figure('Visible', 'off');
    hist2dim = histogram2(vecX1, vecX2, -0.5:1:10.5, -0.5:1:10.5, 'FaceColor', 'flat');
    hold on
    stem3(0:m, 0:m, mat);
    hold off
    saveas(fig, [pwd '/images' strFileName '.png']);
    saveas(fig, [pwd '/images' strFileName '.fig']);
    matCount = hist2dim.Values;
end
