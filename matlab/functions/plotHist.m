% function file
% Author: Edward J. Xu
% Date: 190619
% ######################################################################################################################


function [vecProb, vecXx] = plotHist(vecResult, vecXxStd, vecYyStd, numClass, strFigName, strFigTitle, strFigLegend_1)
    % Plot the histogram of RNG result and return the vector of values
    figure('Visible', 'off');
    figHist = histogram(vecResult, 'NumBins', numClass, 'Normalization', 'probability', 'Visible', 'off');
    vecProb = figHist.Values;
    vecProbClassNorm = vecProb / figHist.BinWidth;  % Normalize the prob with BinWidth
    vecXx = figHist.BinEdges(1:figHist.NumBins) + figHist.BinWidth / 1;
    fig = plot(vecXx, vecProbClassNorm, 'b', 'LineWidth', 2);
    hold on
    plot(vecXxStd, vecYyStd, 'r', 'LineWidth', 2);
    hold off
    title(strFigTitle);
    legend(strFigLegend_1, 'Standard Distribution');
    saveas(fig, [pwd '/images/' strFigName '.png']);
    saveas(fig, [pwd '/images/' strFigName '.fig']);
end
