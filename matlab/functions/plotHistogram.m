% function file
% Author: Edward J. Xu
% Date: 190619
% ######################################################################################################################


function [vecProb, vecXx] = plotHistogram(vecResult, vecXxStd, vecYyStd, vecBinEdge, strFigTitle, strFigName, ...
    strFigLegend)
    % Plot the histogram of RNG result and return the vector of values
    fig = figure('Visible', 'off');
    figHist = histogram(vecResult, 'BinEdges', vecBinEdge, 'Normalization', 'probability', 'Visible', 'off');
    vecProb = figHist.Values;
    vecProbNorm = vecProb / figHist.BinWidth;
    vecXx = vecBinEdge(1:figHist.NumBins) + figHist.BinWidth / 2;
    plot(vecXx, vecProbNorm, 'b', 'LineWidth', 2);
    hold on
    plot(vecXxStd, vecYyStd, 'r', 'LineWidth', 2);
    hold off
    title(strFigTitle);
    legend(strFigLegend, 'Theoretical Result', 'Location', 'northwest');
    saveas(fig, [pwd '/images/' strFigName '.png']);
    saveas(fig, [pwd '/images/' strFigName '.fig']);
end
