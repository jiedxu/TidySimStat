% function file
% Author: Edward J. Xu
% Date: 190619
% ######################################################################################################################


function [fig] = plotStem3(vecXx, vecYy, mat, strFileName)
    fig = figure('Visible', 'off');
    fig = stem3(vecXx, vecYy, mat);  % [0:m], [0:m],
    saveas(fig, [pwd '/images' strFileName '.png']);
    saveas(fig, [pwd '/images' strFileName '.fig']);
end
