% function file
% Author: Edward J. Xu
% Date: 190619
% ######################################################################################################################


function [tabYy] = doExercise_4(nServer, nEvent, nSim, nStable, clockSimZero, mu, lambda)
    fprintf('--------------------------------------------------------------------------------\n')
    fprintf('Set Parameters: \n')
    fprintf('    nEvent = %d ; \n', nEvent)
    fprintf('    nServer = %d ; \n', nServer)
    fprintf('    nStable = %d ; \n', nStable)
    % Initialize the Variables -----------------------------------------------------------------------------------------
    vecWhiFuncArrive = [1 2 3 1 1 1];
    vecWhiFuncServe = [1 1 1 2 3 3];
    if length(vecWhiFuncArrive) ~= length(vecWhiFuncServe)
        error('Wrong Vectors for Function Indicators.')
    else
        nExperiment = length(vecWhiFuncArrive);
    end
    sTabYy(1:(nExperiment + 1)) = struct('fA', NaN, 'fS', NaN, 'expect', NaN, 'variance', NaN, 'lb', NaN, 'ub', NaN, ...
        't', NaN);
    sTabYy(nExperiment + 1).fA = 'exp';
    sTabYy(nExperiment + 1).fS = 'exp';
    sTabYy(nExperiment + 1).expect = calErlangsFormula(8, 1, nServer);
    % sTabZz(1:(nExperiment + 1)) = struct('mean', NaN, 'variance', NaN, 'lb', NaN, 'ub', NaN, 't', NaN);
    % Begin Simulation -------------------------------------------------------------------------------------------------
    for i = 1:nExperiment
        fprintf('--------------------------------------------------------------------------------\n')
        fprintf('Experiment %d : \n', i)
        [sTabYy(i)] = simBlockProblem(nServer, nEvent, nSim, nStable, clockSimZero, mu, lambda, ....
            vecWhiFuncArrive(i), vecWhiFuncServe(i));  % , sTabZz(i)
    end
    % Display the table ------------------------------------------------------------------------------------------------
    fprintf('--------------------------------------------------------------------------------\n')
    fprintf('Simulation Result: \n')
    tabYy = struct2table(sTabYy);
    format shortEng
    disp(tabYy)
    format
    % disp(struct2table(sTabZz))
end


function [sTabYy] = simBlockProblem(nServer, nEvent, nSim, nStable, clockSimZero, mu, lambda, ...
    whiFuncArrive, whiFuncServe)  % , sTabZz
    % 1,  Define Distribution Functions --------------------------------------------------------------------------------
    [funcArrive, vecParaArrive, fA] = getFuncArrive(whiFuncArrive, mu);
    [funcServe, vecParaServe, fS] = getFuncServe(whiFuncServe, lambda);
    % 2,  Multiple Simulation ------------------------------------------------------------------------------------------
    [vecInterEvent, vecProbResult, t] = simMultipleDiscreteEvent(clockSimZero, nServer, nEvent, funcArrive, ...
        funcServe, vecParaArrive, vecParaServe, nStable, nSim);
    % 3,  Result from Simulation ---------------------------------------------------------------------------------------
    % analyzeVec(vecInterEvent, 'Average Inter-Event Time')
    sTabYy.expect = mean(vecProbResult);
    sTabYy.variance = var(vecProbResult);
    [sTabYy.lb, sTabYy.ub] = analyzeVec(vecProbResult, 'Simulated Block Probability');
    sTabYy.t = t;
    sTabYy.fA = fA;
    sTabYy.fS = fS;
    % 4,  Result from Simulation and Control Variate -------------------------------------------------------------------
    % expectYy = 1;
    % vecXx = vecProbResult;
    % vecZz = zeros(nSim, 1);
    % covXxYy = cov(vecXx, vecYy);
    % varXxYy = covXxYy(1, 2);
    % c = - varXxYy / var(vecYy);
    % for i = 1:nSim
    %     vecZz(i) = vecXx(i) + c * (vecYy(i) - expectYy);
    % end
    % variZz = var(vecXx) - varXxYy^2 / var(vecYy);  % The calculation is a bit different. ???
    % sTabZz = analyzeVecResult(vecZz, variZz);
end


function [vecInterEvent, vecProbResult, elapsedTime] = simMultipleDiscreteEvent(clockSimZero, nServer, nEvent, funcArrive, ...
    funcServe, vecParaArrive, vecParaServe, nStable, nSim)
    tic;
    vecProbResult = zeros(nSim, 1);
    vecYy = zeros(nSim, 1);
    for i = 1:nSim
        sState = simDiscreteEvent(clockSimZero, nServer, nEvent, funcArrive, funcServe, ...
            vecParaArrive, vecParaServe);
        vecProbResult(i) = (sState(nEvent).nCustomerBlock - sState(nStable).nCustomerBlock) / (nEvent - nStable);
        vecInterEvent(i) = mean([sState.interEvent]);
    end
    elapsedTime = toc;
end


function [func, vecPara, strFunc] = getFuncArrive(whiFunc, mu)
% To define the function for length of arrival interval and serving time.
%
% Example: mu = 1;
    if whiFunc == 1
        func = @exprnd;
        vecPara = mu;
        strFunc = 'exp';
    elseif whiFunc == 2
        func = @(mu) exprnd(mu / 4) + exprnd(mu / 4) + exprnd(mu / 4) + exprnd(mu / 4);
        vecPara = mu;
        strFunc = 'Erlang';
    elseif whiFunc == 3
        func = @simDistHyperExp2;
        vecPara = [0.8, 0.833, 5];
        strFunc = 'h-exp';
    elseif  whiFunc == 4
        func = @(cons) cons;
        vecPara = mu;
        strFunc = 'cons';
    end
    fprintf('    Function for Inter-Arrival Time: %s.\n', strFunc);
end


function [z] = simDistHyperExp2(vecPara)
    p1 = vecPara(1);
    mean1 = vecPara(2);
    mean2 = vecPara(3);
    if rand() >= p1
        z = exprnd(mean1); % Time between customers
    else % rand < p2
        z = exprnd(mean2); % Time between customers
    end
end



function [func, vecPara, strFunc] = getFuncServe(whiFunc, lambda)
% To define the function for length of arrival interval and serving time.
    if whiFunc == 1
        func = @exprnd;
        vecPara = lambda;
        strFunc = 'exp';
    elseif  whiFunc == 2
        func = @(cons) cons;
        vecPara = lambda;
        strFunc = 'cons';
    elseif whiFunc == 3
        func = @simDistParetoWithoutUu;
        vecPara = [8 * (1.05 - 1) / 1.05, 1.05];
        strFunc = 'Pareto';
    end
    fprintf('    Function for Service Time: %s.\n', strFunc);
end


function [x] = simDistParetoWithoutUu(vecPara)
% vecPara = [beta, k];
    u = rand();
    beta = vecPara(1);
    k = vecPara(2);
    xRaw = beta * (u^(- 1 / k) - 1);
    x = xRaw + beta;
end


function plotSimulation(sState)
    vecXxStd_1 = 0.01:0.01:5;
    vecYyStd_1 = exppdf(vecXxStd_1, mu);
    plotHist([sState.interEvent], vecXxStd_1, vecYyStd_1, 30, '11.png', ...
        'Histogram of Simulated Inter-Arrival and Exponential Distribution', 'Histogram of Inter-Arrival');
    vecXxStd_2 = 0.01:1:40;
    vecYyStd_2 = exppdf(vecXxStd_2, lambda);
    plotHist([sState.timeServe], vecXxStd_2, vecYyStd_2, 30, '12.png', ...
        'Histogram of Simulated Serving Time and Exponential Distribution', 'Histogram of Serving Time');
end


function test()
    nServer = 10;
    nCustomer = 10000;  % 10000;
    clockSimZero = 0;
    % 2,  Define Functions for Length of Arrival Interval and Serve Time
    [funcArrive, vecParaArrive] = getFunc2('expArrive');
    [funcServe, vecParaServe] = getFunc2('expServe');
    % 3,  Begin `numSim`-Times Simulations
    nEvent = nCustomer;
    [b, sState] = simDiscreteEvent(clockSimZero, nServer, nEvent, funcArrive, funcServe, vecParaArrive, vecParaServe);
    plotLine(1:nEvent, [sState.nCustomerBlock], ...
        '13.png', 'The Result of Number of Blocked Customers');
    plotScatter(1:nEvent, [sState.nCustomerServe], ...
        '14.png', 'The Result of Number of Customers being Served');
    [bCap] = calErlangsFormula(8, 1, nServer);
    plotLine(1:nEvent, [sState.b; ones(1, nEvent) * bCap], '15.png', 'The Result of the Probability a Customer is Blocked');
    matTimeDepart = [sState.vecTimeDepart];
    %
    plotSimulation(sState);
end
