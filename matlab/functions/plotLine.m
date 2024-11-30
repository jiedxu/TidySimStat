% function file
% Author: Edward J. Xu
% Date: 190619
% ######################################################################################################################


function [ fig ] = plotLine(vecXx, matYy, strFigName, strTitle)
% Plot the line chart and save in the images folder
%
% Warning: remember to use '' for strFigName instead of "".
    [~, n] = size(matYy);
    fig = figure('Visible', 'off');
    hold on
    for i = 1:n
        fig = plot(vecXx, matYy(:, i), 'LineWidth', 2);
    end
    title(strTitle);
    legend;
    hold off
    saveas(fig, [pwd '/images/' strFigName, '.png']);
    saveas(fig, [pwd '/images/' strFigName, '.fig']);
end  % function
