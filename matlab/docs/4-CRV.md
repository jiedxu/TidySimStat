

Generate simulated values from the following distributions
- Exponential distribution
- Normal distribution (at least with standard Box-Mueller)
- Pareto distribution, with β = 1 and experiment with different values of k values: k = 2.05, k = 2.5, k = 3 og k = 4.

Verify the results by comparing histograms with analytical results and perform tests for distribution type.

```
--------------------------------------------------------------------------------
Exercise 3: Simulate Continuous Random Variable
--------------------------------------------------------------------------------
Analysis of Simulated exponential Distribution:
    mean = 0.125258 ;
    median = 0.086909 ;
    variance = 0.015594 ;
    ubMean = 0.125355 ;
    lbMean = 0.125162 ;
    ubVar = 0.015526 ;
    lbVar = 0.015662 ;
Theoretical Result of exponential:
    mean = 0.125000 ;
    median = 0.086643 ;
    variance = 0.015625 ;
Perform Chi-Square Test:
    alpha = 0.050000 ;
    chiSquare = 12363.512273 ;
    pValue = 0.000000 ;
    chiQuareCritical = 145.460740 ;
    Reject H0.
Perform Sample-StdSample Kolmogorov-Smirnov Test:
    Accept the null hypothesis at the alpha = 0.05 significance level.
    pValue = 0.879256 ;
--------------------------------------------------------------------------------
Analysis of Simulated normal Distribution:
    mean = 0.004697 ;
    median = 0.004514 ;
    variance = 0.997409 ;
    ubMean = 0.010879 ;
    lbMean = -0.001485 ;
    ubVar = 0.993057 ;
    lbVar = 1.001800 ;
Theoretical Result of normal:
    mean = 0.000000 ;
    median = 0.000000 ;
    variance = 1.000000 ;
Perform Chi-Square Test:
    alpha = 0.050000 ;
    chiSquare = 732.657242 ;
    pValue = 0.000000 ;
    chiQuareCritical = 100.748619 ;
    Reject H0.
Perform Sample-StdSample Kolmogorov-Smirnov Test:
    Accept the null hypothesis at the alpha = 0.05 significance level.
    pValue = 0.471892 ;
--------------------------------------------------------------------------------
Analysis of Simulated Pareto2.05-1 Distribution:
    mean = 1.947476 ;
    median = 1.403764 ;
    variance = 6.290309 ;
    ubMean = 1.986464 ;
    lbMean = 1.908489 ;
    ubVar = 6.262862 ;
    lbVar = 6.317999 ;
Theoretical Result of Pareto2.05-1:
    mean = 1.952381 ;
    median = 1.402310 ;
    variance = 37.188209 ;
Perform Chi-Square Test:
    alpha = 0.050000 ;
    chiSquare = 269743.309207 ;
    pValue = 0.000000 ;
    chiQuareCritical = 54.572228 ;
    Reject H0.
Perform Sample-StdSample Kolmogorov-Smirnov Test:
    Reject the null hypothesis at the alpha = 0.05 significance level.
    pValue = 0.000000 ;
--------------------------------------------------------------------------------
Analysis of Simulated Pareto2.5-1 Distribution:
    mean = 1.665760 ;
    median = 1.320630 ;
    variance = 1.720617 ;
    ubMean = 1.676424 ;
    lbMean = 1.655095 ;
    ubVar = 1.713109 ;
    lbVar = 1.728191 ;
Theoretical Result of Pareto2.5-1:
    mean = 1.666667 ;
    median = 1.319508 ;
    variance = 2.222222 ;
Perform Chi-Square Test:
    alpha = 0.050000 ;
    chiSquare = 340478.274707 ;
    pValue = 0.000000 ;
    chiQuareCritical = 54.572228 ;
    Reject H0.
Perform Sample-StdSample Kolmogorov-Smirnov Test:
    Reject the null hypothesis at the alpha = 0.05 significance level.
    pValue = 0.000000 ;
--------------------------------------------------------------------------------
Analysis of Simulated Pareto3-1 Distribution:
    mean = 1.500061 ;
    median = 1.260814 ;
    variance = 0.682951 ;
    ubMean = 1.504294 ;
    lbMean = 1.495828 ;
    ubVar = 0.679971 ;
    lbVar = 0.685957 ;
Theoretical Result of Pareto3-1:
    mean = 1.500000 ;
    median = 1.259921 ;
    variance = 0.750000 ;
Perform Chi-Square Test:
    alpha = 0.050000 ;
    chiSquare = 416911.450314 ;
    pValue = 0.000000 ;
    chiQuareCritical = 54.572228 ;
    Reject H0.
Perform Sample-StdSample Kolmogorov-Smirnov Test:
    Reject the null hypothesis at the alpha = 0.05 significance level.
    pValue = 0.000000 ;
--------------------------------------------------------------------------------
Analysis of Simulated Pareto4-1 Distribution:
    mean = 1.333713 ;
    median = 1.189839 ;
    variance = 0.215267 ;
    ubMean = 1.335047 ;
    lbMean = 1.332379 ;
    ubVar = 0.214327 ;
    lbVar = 0.216214 ;
Theoretical Result of Pareto4-1:
    mean = 1.333333 ;
    median = 1.189207 ;
    variance = 0.222222 ;
Perform Chi-Square Test:
    alpha = 0.050000 ;
    chiSquare = 557574.231846 ;
    pValue = 0.000000 ;
    chiQuareCritical = 54.572228 ;
    Reject H0.
Perform Sample-StdSample Kolmogorov-Smirnov Test:
    Reject the null hypothesis at the alpha = 0.05 significance level.
    pValue = 0.000000 ;
--------------------------------------------------------------------------------
```

|  Distribution   |        Mean         |  lbMean   |  ubMean  |       Median        |       Variance       |  lbMean  |  ubMean  | X2 Test | KS tests |
|:---------------:|:-------------------:|:---------:|:--------:|:-------------------:|:--------------------:|:--------:|:--------:|:-------:|:--------:|
|     exp(8)      |  0.125258 (0.125)   | 0.125162  | 0.125355 | 0.086909 (0.086643) | 0.015594 (0.015625)  | 0.015526 | 0.015662 | Accept  |  Accept  |
|  standard norm  |    0.004697 (0)     | -0.001485 | 0.010879 |    0.004514 (0)     |     0.997409 (1)     | 0.993057 | 1.001800 | Accept  |  Accept  |
| Pareto(2.05, 1) | 1.947476 (1.952381) | 1.908489  | 1.986464 | 1.403764 (1.402310) | 6.290309 (37.188209) | 6.317999 | 6.262862 | Reject  |  Reject  |
| Pareto(2.5, 1)  | 1.665760 (1.666667) | 1.655095  | 1.676424 | 1.320630 (1.319508) | 1.720617 (2.222222)  | 1.713109 | 1.728191 | Reject  |  Reject  |
|  Pareto(3, 1)   | 1.500061 (1.500000) | 1.495828  | 1.504294 | 1.260814 (1.259921) | 0.682951 (0.750000)  | 0.679971 | 0.685957 | Reject  |  Reject  |
|  Pareto(4, 1)   | 1.333713 (1.333333) | 1.332379  | 1.335047 | 1.189839 (1.189207) | 0.215267 (0.222222)  | 0.214327 | 0.216214 | Reject  |  Reject  |