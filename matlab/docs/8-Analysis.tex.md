---
for: edxu96/TidySimStat/docs
author: Edward J. Xu
date: Mar 4, 2020
---

# Statistical Analysis of Simulated Data

- [x] Sample Mean and Sample Variance
- [x] When to Stop Generating New Data
- [x] Interval Estimates of a Population Mean
- [ ] The Bootstrapping Technique for Estimating Mean Square Errors

## 1. Sample Mean and Sample Variance

* Sample mean: $\bar{X} \equiv \sum_{i=1}^{n} \frac{X_{i}}{n}$
* Sample variance: $S^{2}=\frac{\sum_{i=1}^{n}\left(X_{i}-\bar{X}\right)^{2}}{n-1}$

\(\bar{X},\) the sample mean of the \(n\) data values \(X_{1}, \ldots, X_{n},\) is a random variable with mean \(\theta\) and variance \(S^{2} / n .\) Because a random variable is unlikely to be too many standard deviations--equal to the square root of its variance--from its mean, it follows that \(\bar{X}\) is a good estimator of \(\theta\) when \(\sigma / \sqrt{n}\) is small.

## 2. When to Stop Generating New Data

## 3. Interval Estimates of a Population Mean

## 4. The Bootstrapping Technique for Estimating Mean Square Errors

- A technique for estimating the variance (etc) of an estimator
- Based on sampling from the empirical distribution.
- Non-parametric technique

we don't want want to assume anything specific about F

### Exercise 8: Bootstrap to Analyze Pareto Simulation

Write a subroutine that takes as input a “data” vector of observed values, and which outputs the median as well as the bootstrap estimate of the variance of the median, based on `r = 100` bootstrap replicates.

Test the method: Simulate `n = 200` Pareto distributed random variates with `beta = 1` and `k = 1.05`. Compute the mean, the median, and the bootstrap estimate of the variance of the sample median.

Compare the precision of the estimated median with the precision of the estimated mean.

```
--------------------------------------------------------------------------------
Exercise 8: Bootstrap
--------------------------------------------------------------------------------
Set Parameters:
    beta = 1.000000 ;
    k = 1.050000 ;
    nObs = 200 ;
--------------------------------------------------------------------------------
Analysis of Simulated Pareto Distribution:
    mean = 5.096183 ;
    median = 1.862766 ;
    variance = 172.119351 ;
    ubMean = 29.096227 ;
    lbMean = -18.903861 ;
    ubVar = 156.742619 ;
    lbVar = 190.867438 ;
--------------------------------------------------------------------------------
Boostrap:
    nSet = 100 ;
    timeElapsed = 0.033649 ;
Analysis of vecMean from boostrap:
    mean = 5.182998 ;
    variance = 0.874796 ;
    ubMean = 5.356576 ;
    lbMean = 5.009419 ;
    ubVar = 0.768077 ;
    lbVar = 1.016229 ;
Analysis of vecMedian from boostrap:
    mean = 1.884051 ;
    variance = 0.016174 ;
    ubMean = 1.887261 ;
    lbMean = 1.880842 ;
    ubVar = 0.014201 ;
    lbVar = 0.018789 ;
Analysis of vecVar from boostrap:
    mean = 177.895556 ;
    variance = 9159.991066 ;
    ubMean = 1995.436511 ;
    lbMean = -1639.645399 ;
    ubVar = 8042.534860 ;
    lbVar = 10640.934960 ;
--------------------------------------------------------------------------------
Theoretically:
    mean = 21.000000 ;
    median = 1.935064 ;
    We cannot get theoretical value for variance ;
--------------------------------------------------------------------------------
```

|   Name    |  Method   |   Mean   | Theoretical |  lbMean  |  ubMean  | Variance |  lbVar   |  ubVar   |
|:---------:|:---------:|:--------:|:-----------:|:--------:|:--------:|:--------:|:--------:|:--------:|
|  vecMean  | bootstrap | 5.182998 |  21.000000  | 5.009419 | 5.356576 | 0.874796 | 1.016229 | 0.768077 |
| vecMedian | bootstrap | 1.884051 |  1.935064   | 1.880842 | 1.887261 | 0.016174 | 0.018789 | 0.014201 |

|         Name          |   Mean   |  lbMean   |   ubMean   |  Median  |  Variance  |   lbVar    |   ubVar    |
|:---------------------:|:--------:|:---------:|:----------:|:--------:|:----------:|:----------:|:----------:|
| Simulated Pareto Dist | 5.096183 | 29.096227 | -18.903861 | 1.862766 | 172.119351 | 156.742619 | 190.867438 |

---

[_sheldon2012simulation_]: https://github.com/edxu96/symposium/tree/master/src/sim
