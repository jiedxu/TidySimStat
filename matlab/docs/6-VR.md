
## 1,  Variance-Reduction Techniques


## 2,  Exercise 5: Calculate a Simple Integral using Variance-Reduction Techniques

```
--------------------------------------------------------------------------------
Exercise 5: Variance Reduction
--------------------------------------------------------------------------------
Analytical Result:
    value = 1.718282 ;
--------------------------------------------------------------------------------
Simulation Result:
    nSample = 10000 ;
    method is crude exp ;
Elapsed time is 0.008408 seconds.
--------------------------------------------------------------------------------
Analysis of Simulation Result:
    mean = 1.723187 ;
    median = 1.661517 ;
    variance = 0.242415 ;
    ubMean = 1.727939 ;
    lbMean = 1.718435 ;
    ubVar = 0.239101 ;
    lbVar = 0.245822 ;
--------------------------------------------------------------------------------
Simulation Result:
    nSample = 10000 ;
    method is antithetic ;
Elapsed time is 0.002669 seconds.
--------------------------------------------------------------------------------
Analysis of Simulation Result:
    mean = 1.718536 ;
    median = 1.700028 ;
    variance = 0.004000 ;
    ubMean = 1.718614 ;
    lbMean = 1.718458 ;
    ubVar = 0.003945 ;
    lbVar = 0.004056 ;
--------------------------------------------------------------------------------
Simulation Result:
    nSample = 10000 ;
    method is control variate ;
Elapsed time is 0.004574 seconds.
--------------------------------------------------------------------------------
Analysis of Simulation Result:
    mean = 1.718248 ;
    median = 1.700845 ;
    variance = 0.003934 ;
    ubMean = 1.718325 ;
    lbMean = 1.718171 ;
    ubVar = 0.003880 ;
    lbVar = 0.003989 ;
--------------------------------------------------------------------------------
Simulation Result:
    nSample = 10000 ;
    method is stratified ;
Elapsed time is 0.011041 seconds.
--------------------------------------------------------------------------------
Analysis of Simulation Result:
    mean = 1.718222 ;
    median = 1.718229 ;
    variance = 0.000270 ;
    ubMean = 1.718228 ;
    lbMean = 1.718217 ;
    ubVar = 0.000266 ;
    lbVar = 0.000273 ;
--------------------------------------------------------------------------------
```

Estimate the integral by simulation. Present the point estimator and confidence interval.

|   Method    | nSample |    Mean    | Variance | Lower Bound | Upper Bound | Elapsed Time |
|:-----------:|:-------:|:----------:|:--------:|:-----------:|:-----------:|:------------:|
|    crude    |  10000  |  1.722460  | 0.244188 |  1.712773   |  1.732146   |  0.011881 s  |
| antithetic  |  10000  |  1.718064  | 0.003885 |  1.716842   |  1.719286   |  0.005309 s  |
|   control   |  10000  |  1.717911  | 0.003901 |  1.716687   |  1.719136   |  0.007101 s  |
| stratified  |  10000  |  1.718110  | 0.000263 |  1.718428   |  1.717792   |  0.008605 s  |
| theoretical |    -    | (1.718282) | 0.242036 |      -      |      -      |      -       |

## 3,  Use Control Variates in Exercise 4

|        Method        |   Mean   | Variance | Lower Bound | Upper Bound | Elapsed Time |
|:--------------------:|:--------:|:--------:|:-----------:|:-----------:|:------------:|
|       exp/exp        | 0.121679 | 0.000040 |  0.121428   |  0.121930   | 23.269757 s  |
|  analytical result   | 0.121661 |    -     |      -      |      -      |      -       |
| e/e control variates | 0.121705 | 0.000025 |  0.121504   |  0.121905   |      -       |


importance sampling
