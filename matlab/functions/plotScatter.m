% function file
% Author: Edward J. Xu
% Date: 190619
% ######################################################################################################################


function [ fig ] = plotScatter( vecX, matY, strFigName, strTitle )
% Plot the line chart and save in the images folder
%
% Warning: remember to use '' for strFigName instead of "".
    [m, n] = size(matY);
    fig = figure("Visible", "off");
    hold on
    for i = 1:m
        fig = scatter(vecX, matY(i, :), 'LineWidth', 2);
    end
    title(strTitle);
    legend;
    hold off
    saveas(fig, [pwd '/images/' strFigName]);
end  % function
