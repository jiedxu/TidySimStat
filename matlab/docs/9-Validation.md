---
for: edxu96/TidySimStat/docs
author: Edward J. Xu
date: Mar 4, 2020
---

# Statistical Validation of Probability Models

## 1. Goodness of Fit Tests

> One often begins a probabilistic analysis of a given phenomenon by hypothesizing that certain of its random elements have a particular probability distribution. For example, we might begin an analysis of a traffic network by supposing that the daily number of accidents has a Poisson distribution. Such hypotheses can be statistically tested by observing data and then seeing whether the assumption of a particular probability distribution is consistent with these data. These statistical tests are called goodness of fit tests. [_sheldon2012simulation_]

> One way of performing a goodness of fit test is to first partition the possible values of a random quantity into a finite number of regions. A sample of values of this quantity is then observed and a comparison is made between the numbers of them that fall into each of the regions and the theoretical expected numbers when the specified probability distribution is indeed governing the data. [_sheldon2012simulation_]

### The Chi-Square Goodness of Fit Test for Discrete Data

```matlab
function testChiSquare(vecObs, vecExp, alpha)
% Perform Chi-Square Test
% Hypothesis 0: the simulated vecObs can represent vecExp from analytical result
% Warning: If the simulation produces count, vecObs should be count instead of probability
    fprintf('Perform Chi-Square Test: \n')
    fprintf('    alpha = %f ; \n', alpha)
    numClass = length(vecObs);
    vecResultTest = zeros(numClass, 1);
    for i = 1:numClass
        vecResultTest(i) = (vecObs(i) - vecExp(i))^2 / vecExp(i);
    end
    chiSquare = sum(vecResultTest);
    fprintf('    chiSquare = %f ;\n', chiSquare)
    pValue = 1 - chi2cdf(chiSquare, numClass - 1 - 0);
    fprintf('    pValue = %f ;\n', pValue)
    chiQuareCritical = chi2inv((1 - alpha), numClass - 1 - 0);
    fprintf('    chiQuareCritical = %f ;\n', chiQuareCritical)
    if chiSquare > chiQuareCritical
        fprintf('    Reject H0. \n')
    else
        fprintf('    Accept H0. \n')
    end
end
```

### The Kolmogorov_Smirnov Test for Continuous Data

## Confidence Interval

```matlab
function [lb, ub] = calInterConf(vecResult, alpha)
% Calculate the Confidence Interval of vecResult
% default: alpha = 0.05
% ub: upper bound ; lb: lower bound ;
    n = length(vecResult);
    expect = mean(vecResult);
    se = sqrt(sum((vecResult - expect).^2) / (n - 1));
    % se = (sum(vecResult.^2) - n * expect^2) / (n - 1);
    lb = expect - se * tinv(1 - alpha / 2, n - 1) / sqrt(n);
    ub = expect + se * tinv(1 - alpha / 2, n - 1) / sqrt(n);
end
```

## 2. Goodness of Fit Tests with Some Parameters Unspecified

## 3. The Two-Sample Problem

---

[_sheldon2012simulation_]: https://github.com/edxu96/symposium/tree/master/src/sim
