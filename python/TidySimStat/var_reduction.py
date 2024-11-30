
import random as rd
import math
import pandas as pd
import numpy as np

from TidySimStat.estimation import *

DF = pd.core.frame.DataFrame


def eval_int(f_derivative, n:int=1000) -> DF:
    """Evaluate the definite integral using simulation.

    Keyword Arguments
    =================
    f_derivative: derivative function to integrate
    n: number of simulation runs

    Attentions
    ==========
    - Right now, the interval for the definite integral is [0, 1].
    """
    if callable(f_derivative) is not True:
        raise ValueError("The input derivative function is not callable.")

    us = [rd.random() for i in range(n)]
    xs = [f_derivative(u) for u in us]

    return pd.DataFrame({"u": us, "x": xs})


def reduce_stratified(sample:DF) -> DF:
    """Reduce the variance of raw smulation estimator by stratified sampling.

    Attentions
    ==========
    - The variance of the stratified sampling estimator is not the variance of
      obtained conditional means.
    - So far, the only stratified sampling is uniform distribution over [0, 1].
    """
    sample["y"] = [math.floor(i) + 1 for i in sample["u"] * 10]
    xbars_y = [0 for i in range(10)]
    vars_y = [0 for i in range(10)]
    len_y = [0 for i in range(10)]
    for i in range(10):
        sample_y = sample.loc[sample["y"] == i+1]
        xbars_y[i] = cal_mean_sample(sample_y["x"])
        vars_y[i] = cal_var_sample(sample_y["x"])
        len_y[i] = sample_y.shape[0]

    return pd.DataFrame({"y": [i for i in range(10)], "xbar": xbars_y,
        "var": vars_y, "n": len_y})


def analyse_stratified(results:DF, n:int):
    """Analyse mean and variance of stratified sampling.

    Keyword Arguments
    =================
    results: results from variance reduction by stratified sampling.
    n: number of simulation runs.
    """
    mean = cal_mean_sample(results['xbar'])  # sample mean
    var = sum(results['var']) / 10  # sample variance
    return mean, var


def reduce_antithetic_int(f_derivative, sample:DF) -> DF:
    """Reduce the variance of raw smulation estimator using antithetic variate.

    Keyword Arguments
    =================
    f_derivative: derivative function to integrate.
    sample: pandas dataframe containing raw simulation results.
    """
    if callable(f_derivative) is not True:
        raise ValueError("The input derivative function is not callable.")

    sample["u2"] = 1 - sample["u"]
    sample["x2"] = sample["u2"].apply(f_derivative)
    n = sample.shape[0]
    sample["y"] = (sample["x"] + sample["x2"]) / 2
    return sample


def reduce_control(sample:DF) -> DF:
    """Reduce the variance of raw smulation estimator by control variates.

    Keyword Arguments
    =================
    sample: pandas dataframe containing raw simulation results.
    """
    cov_xu = sample[['x', 'u']].cov()['x'][1]
    var_u = cal_var_sample(sample['u'])
    c = - cov_xu / var_u
    sample['y'] = sample['x'] + c * (sample['u'] - 0.5)
    return sample
