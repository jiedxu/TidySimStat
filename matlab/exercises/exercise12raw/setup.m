% setup file for exercises in stochastic simulation
% by Edward J. Xu and Sanaz
% 190606
% ######################################################################################################################
% cd Documents/GitHub/StochasticSim
% pwd
addpath("/Users/fengguangjie/Documents/GitHub/StochasticSim")
% ######################################################################################################################
% 1,  Random Number Generation and Analysis
mCap = 10000;
a    = 24298;
c    = 99991;
x0   = 199017;
% mCap = 16;
% a    = 5;
% c    = 1;
% x0   = 3;
[vecRanNum, vecCumuProb] = getRngLcg(mCap, a, c, x0);
% vecRanNum = testRngLcg(mCap, a, c, x0, 'figHistRNG.png');
% ######################################################################################################################

% ######################################################################################################################
% 3,  For the normal distribution, generate 95% confidence intervals for the mean and variance based on 10 experiments.
vecExpectNorm = zeros(10, 1);
vecVarNorm = zeros(10, 1);
for i = 1:10
    rng(i); vecRanNumNorm_4 = rand(10000, 1);
    [vecSimNorm, vecProbClass] = distNormPdf(vecRanNumNorm_4, vecTriU2, 100, 'figHistNorm.png');
    vecExpectNorm(i) = mean(vecSimNorm);
    vecVarNorm(i) = var(vecSimNorm);
end
clear vecRanNumNorm_4, vecSimNorm, vecProbClass
intervalConfExpect = zeros(2, 1);
intervalConfVar = zeros(2, 1);
intervalConfExpect(1) = mean(vecExpectNorm) - tpdf(sqrt(var(vecExpectNorm)), 10 - 1);
intervalConfExpect(2) = mean(vecExpectNorm) + tpdf(sqrt(var(vecExpectNorm)), 10 - 1);
intervalConfVar(1) = mean(vecVarNorm) - tpdf(sqrt(var(vecVarNorm)), 10 - 1);
intervalConfVar(2) = mean(vecVarNorm) + tpdf(sqrt(var(vecVarNorm)), 10 - 1);
