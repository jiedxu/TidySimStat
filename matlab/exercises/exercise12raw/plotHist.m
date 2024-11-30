function [ vecProbClass ] = plotHist( vecResult, vecXstd, vecYstd, numClass, strFigName )
    % Plot the histogram of RNG result and return the vector of values
    figHist = figure("Visible", "off");
    hold on
    figHist = histogram(vecResult, 'NumBins', numClass, 'Normalization', 'probability', "Visible", "off");
    vecProbClass = figHist.Values;
    vecProbClassNorm = vecProbClass / figHist.BinWidth;
    vecX = figHist.BinEdges(1:figHist.NumBins);
    vecX = vecX + figHist.BinWidth / 1;
    figHist = plot(vecX, vecProbClassNorm, 'b', 'LineWidth', 2);
    figHist = plot(vecXstd, vecYstd, 'r', 'LineWidth', 2);
    hold off
    saveas(figHist, [pwd '/images/' strFigName]);
end
