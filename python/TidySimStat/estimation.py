
import numpy as np
from typing import Union
import scipy.stats as st
import math


def cal_mean_sample(sample:list, var_pop:int=None,
        mute:bool=True) -> Union[list, float]:
    """Calculate sample mean and its variance if the population variance
    is given.

    Attentions
    ==========
    - Usually, the population variance `var_pop` is represented by
      `\sigma^2`.
    """
    mean_sample = np.mean(sample)
    if not mute:
        print(f"Sample mean: {mean_sample} .")

    var_mean_sample = None
    if var_pop is not None:
        n = len(sample)  # size of the sample
        var_mean_sample = var_pop / n
        if not mute:
            print(f"Variance of sample mean: {var_mean_sample} .")

    if var_pop is None:
        return mean_sample
    else:
        return [mean_sample, var_mean_sample]


def cal_var_sample(sample:list, mute:bool=True) -> float:
    """Calculate the sample variance."""
    mean_sample = cal_mean_sample(sample)
    n = len(sample)
    var_sample = sum([(i - mean_sample)**2 for i in sample]) / (n-1)

    if not mute:
        print(f"Sample variance: {var_sample} .")

    return var_sample


def update_mean_sample(mean_sample:float, n:float,
        sample_new:Union[float, list]) -> float:
    """Update the sample recursively.

    Keyword Arguments
    =================
    mean_sample: existing sample mean
    n: size of sample for the existing sample mean
    sample_new: a new single sample
    """
    mean_sample_new = mean_sample + (sample_new - mean_sample) / (n+1)
    return mean_sample_new


def update_var_sample():
    pass


def est_interval(sample:list, alpha:float=0.05,
        var_pop:int=None, mute:bool=True) -> list:
    """Interval estimation of the population mean based on the given
    sample and significance level alpha.

    Attentions
    ==========
    - Usually, the population variance `var_pop` is represented by
      `\sigma^2`. Sometimes, the population standard deviance `\sigma`
      is given.
    """
    mean = cal_mean_sample(sample)
    n = len(sample)

    if var_pop is not None:
        z_alpha2 = st.norm.ppf(1 - alpha / 2)
        interval = [mean - z_alpha2 * math.sqrt(var_pop / n),
            mean + z_alpha2 * math.sqrt(var_pop / n)]
    else:
        var = cal_var_sample(sample)
        interval = est_interval_mean_var(mean, var, n, alpha)

    if not mute:
        print(f"Interval estimator: [{interval[0]}, {interval[1]}] .")

    return interval


def est_interval_mean_var(mean:float, var:float, n:int, alpha:float=0.05):
    t_alpha2 = st.t.ppf(1 - alpha / 2, df=n-1)
    interval = [mean - t_alpha2 * math.sqrt(var / n),
        mean + t_alpha2 * math.sqrt(var / n)]
    return interval


def est_three_points(sample:list, alpha:float=0.05,
        var_pop:int=None, mute:bool=True) -> list:
    mean = cal_mean_sample(sample, var_pop, mute)
    interval = est_interval(sample, alpha, var_pop, mute)
    return [interval[0], mean, interval[1]]
