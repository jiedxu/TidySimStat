
## 1,  Exercise 4: Discrete Event Simulation of Blocking System

| Id  |   Inter-Arrival Time   |    Service Time    | Theoretically |   Mean   |  Variance  |     LB     |     UB     | Ela-Time |
|:---:|:----------------------:|:------------------:|:-------------:|:--------:|:----------:|:----------:|:----------:|:--------:|
|  1  |         exp(1)         |       exp(8)       |   0.121661    | 0.121679 |  0.000040  |  0.121428  |  0.121930  | 23.269 s |
|  2  |       Erlang(1)        |       exp(8)       |       -       | 0.07743  |  0.000023  |  0.077425  |  0.077435  | 36.285 s |
|  3  | he(0.8-0.833, 0.2-5.0) |       exp(8)       |       -       | 0.000143 | 2.6718e-08 | 0.00014299 | 0.00014301 | 21.884 s |
|  4  |         exp(1)         |      cons(8)       |   0.121661    | 0.12187  |  0.000020  |  0.12186   |  0.12187   | 15.135 s |
|  5  |         exp(1)         | Pareto(1.05, 0.38) |   0.120757    | 0.001418 |  0.000006  | 0.0014166  | 0.0014194  | 16.210 s |
|  6  |         exp(1)         | Pareto(2.05, 4.10) |   0.121876    | 0.001277 |  0.000003  | 0.0012762  | 0.0012778  | 17.511 s |

he: hyper-exponential distribution
Pareto: beta = 8 * (k - 1) / k

## 2,  Note

Renewal process is the sum of independent non-negative distribution, and Poisson process is the easiest renewal process.

Most of the time, Poisson distribution can do the job.

Alternative distributions for non-negative random variables:
- Hyper Exponential
- Erlang / Gamma
- Log Normal
- Pareto

Log normal and Pareto distribution is generally only treatable by simulation.

`thetaHat` estimator

If `mean(thetaHat) == theta`, `thetaHat` is central.

`lambda` arrival time

`mu` service time

offered traffic , and number of servers are the only two input parameters.

poisson process: sum of independently exponential distributed intervals.
