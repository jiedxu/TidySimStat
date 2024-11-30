
import scipy.stats as st
import random as rd
import math
import numpy as np

from TidySimStat.auxiliary import cdf2pmf
from TidySimStat.drv import set_alias_direct, run_alias_direct


def cal_pvalue_norm(stat, mute:bool=True):
    """Calculate the p value of two-sided Z-test using standard normal
    distribution."""
    if stat > 0:
        pvalue = 2 * (1 - st.norm.cdf(stat, 0, 1))
    else:
        pvalue = 2 * st.norm.cdf(stat, 0, 1)
    if not mute:
        print(f"The input stat: {stat:.4f}. \n"
            f"The p value from normal distribution: {pvalue:.4f}.")
    return pvalue


def cal_pvalue_chi2(stat, df, mute:bool=True):
    """Calculate the pvalue of two-sided t-test using Chi-Square distribution."""
    pvalue = 1 - st.chi2.cdf(stat, df)
    if not mute:
        print(f"The input stat: {stat:.4f}. \n"
            f"The p value from Chi-Square distribution: {pvalue:.4f}.")
    return pvalue


def infer_independence(pvalue, alpha:float=0.05, mute:bool=True):
    """Perform independence test.

    Returns
    =======
    Whether the given samples are generated independently.
    """
    if not mute:
        print("Null hypothesis: given samples are generated independently. \n"
            f'The input p value is {pvalue:.4f}. \n'
            f'Is the p value smaller than {alpha}? {pvalue < alpha}. \n'
            f'If to reject the null hypothesis? {pvalue <= alpha}. \n'
            f'If given samples are independent? {pvalue >= alpha}. \n')

    return pvalue >= alpha


def infer_dist(pvalue:float, alpha:float=0.05, mute:bool=True):
    """Perform statistical test regarding distributions of two populations.

    Returns
    =======
    Whether the tested distribution is the same as the given one.

    Notes
    =====
    We reject the null hopythesis when the statistic is sufficiently large.
    """
    if not mute:
        print("Null hypothesis: two populations have the same distribution. \n"
            f"The input p value is {pvalue:.4f}. \n"
            f"Is the p value smaller than {alpha}? {pvalue < alpha}. \n"
            f"If reject the null hypothesis? {pvalue < alpha}. \n"
            f"If from the same distribution? {pvalue >= alpha}. \n")

    return pvalue >= alpha


def infer_corr(pvalue:float, alpha:float=0.05, mute:bool=True):
    """Perform correlation test."""
    if not mute:
        print("Null hypothesis: the samples are not correlated. \n"
            f"The input p value is {pvalue:.4f}. \n"
            f"Is the p value smaller than {alpha}? {pvalue < alpha}. \n"
            f"If reject the null hypothesis? {pvalue <= alpha}. \n"
            f"If the samples are correlated? {pvalue <= alpha}.")

    return pvalue >= alpha


def cal_pvalue_ks(stat:float, n:int, m:int=1000, mute:bool=True) -> float:
    """Obtain the p value corresponding a statistic from One-Sample
    Kolmogorov–Smirnov test by simulations.

    Keyword Arguments
    =================
    n: size of the original sample.
    m: number of simulation runs (default 10000).

    Attentions
    ==========
    - The number of random numbers `n` in each simulation run must be equal to
      the size of the original sample.
    - According to theoretical analysis, the p value is irrelavant to the
      target distribution.
    """
    num_good = 0  # A counter to remember the number of good runs
    for i in range(m):
        u = [rd.random() for j in range(n)]
        u.sort()
        d_sim = [j / n - u[j] for j in range(1, (n-1))] + \
            [u[j] - (j-1) / n for j in range(1, (n-1))]
        ## If the value is larger than `stat`, we say it is a good run.
        if max(d_sim) >= stat:
            num_good += 1

    pvalue = num_good / m
    if not mute:
        print(f"One-sample Kolmogorov–Smirnov test p-value: {pvalue:.4f}.")

    return pvalue


def cal_stat_ks(samples, cdf, mute:bool=True):
    """Calculate the statistic in one-sample Kolmogorov–Smirnov test for
    distribution of a continuous random variable.

    Keyword Arguments
    =================
    samples: list of samples
    cdf: target cumulative density function
    """
    samples.sort()
    n = len(samples)
    li = [(j+1) / n - cdf(samples[j]) for j in range(n)] + \
        [cdf(samples[j]) - j / n  for j in range(n)]
    stat = max(li)
    if not mute:
        print(f"One-sample Kolmogorov–Smirnov test: {stat:.4f}.")

    return stat


def count_gof(samples:list, end_left:float=0, end_right:float=1, k:int=10):
    """Count numbers of samples in different intervals of Chi-Squared
    Goodness-of-Fit Test for a continuous random variable.

    Keyword arguments
    =================
    samples: list of samples to be tested
    end_left: minimum possible value of the distribution
    end_right: maximum possible value of the distribution
    k: number of intervals in the test.

    Returns
    =======
    counts: list of counts in different intervals
    ends: list of left end of intervals

    Attentions
    ==========
    x[i] = [1, 2, 3, ..., k+1] for i = 0, 1, 2, ..., k
    """
    if end_left >= end_right:
        raise Exception("end_left >= end_right!")

    span = (end_right - end_left) / k  # Length of intervals
    ends = [end_left + (i+1) * span for i in range(k)]
    ends[-1] = end_right

    counts = [0 for i in range(k)]
    samples.sort()

    j = 0
    i = 0
    counter = 0

    ## The left side is considered in the first interval
    while samples[i] == end_left:
        counter += 1
        i += 1

    while i < len(samples):
        if samples[i] <= ends[j] and samples[i] > ends[j] - span:
            counter += 1
            i += 1
        else:
            counts[j] = counter + 0
            while not (samples[i] <= ends[j] and
                    samples[i] > ends[j] - span):
                j += 1
            counter = 1
            i += 1
    counts[j] = counter + 0

    return counts, ends


def cal_stat_gof(counts:list, pmf:list, mute:bool=True):
    """Calculate the statistic in Goodness of Fit test for the distribution
    of a discrete random variable or a continuous random variable.

    Keyword Arguments
    =================
    counts: list of counts in different intervals
    pmf: list representing probablity mass function of the target distribution

    Attentions
    ==========
    The function can be used for both discrete and continuous random variables.
    """
    n = sum(counts)
    k = len(pmf)
    stat = sum([(counts[i] - n * pmf[i])**2 / n / pmf[i] for i in range(k)])
    if not mute:
        print(f"Chi-squared goodness of fit test: {stat:.4f}.")

    return stat


def cal_pvalue_gof(stat:float, pmf:list, n:int, num_sim:int=1000):
    """Calculate the exact p value of Chi-Squared Goodness of Fit test using
    simulations.

    Attentions
    ==========
    x[i] = [1, 2, 3, ..., k+1] for i = 0, 1, 2, ..., k
    """
    f, l = set_alias_direct(pmf)
    k = len(pmf)

    def cal_t():
        samples = [run_alias_direct(f, l) for i in range(n)]
        counts = [samples.count(i+1) for i in range(k)]
        t = sum([(counts[i] - n * pmf[i])**2 / n / pmf[i]
            for i in range(k)])
        return t

    ts = [cal_t() for j in range(num_sim)]

    pvalue = sum([t >= stat for t in ts]) / num_sim
    return pvalue


def get_binary_ww(li):
    """Transform the list to binary list for Wald–Wolfowitz runs test.

    Attention
    =========
    - The median is used.
    """
    m = np.median(li)
    li_binary = [1 if i > m else 0 for i in li]
    return li_binary


def cal_stat_runs_ww(li, mute:bool=True):
    """Calculate the statistic of Wald–Wolfowitz runs test.

    Attention
    =========
    - The statistic follows normal distribution. That is, The number of
      runs (above/below the median) is asymptotically approach normal
      distribution with the sample mean `mu` and sample variance `se`.
    - Runs tests are especially designed for randomness.
    - We call any consecutive sequence of either 0s or 1s a run.
    """
    n1 = sum(li)
    n2 = len(li) - n1
    ## Number of runs
    num_runs = cal_num_runs(li)
    ## Expected of the number of runs
    mu = (2 * n1 * n2) / (n1 + n2) + 1
    ## Expected of standard error the number of runs
    se = math.sqrt( 2 * n1 * n2 * (2 * n1 * n2 - n1 - n2) /
        (n1 + n2)**2 / (n1 + n1 - 1) )
    stat = (num_runs - mu) / se
    if not mute:
        print(f'Wald–Wolfowitz runs test: {stat:.4f}. \n'
            f'Number of runs: {num_runs}.')

    return stat


def cal_num_runs(li:list):
    """It is assumed that the input list is binary.
    """
    if sum( [(i == 1 or i == 0) for i in li] ) != len(li):
        raise ValueError("The input is not a binary list.")

    x1 = li[0]
    num_runs = 1
    for x in li:
        if x != x1:
            x1 = x
            num_runs += 1
    return num_runs


# def cal_num_runs_2(li:list):
#     """It is assumed that the input list is binary.
#     """
#     if sum( [(i == 1 or i == 0) for i in li] ) != len(li):
#         raise ValueError("The input is not a binary list.")
#
#     x1 = li[0]
#     num_runs = 1
#     if x1 == 1:
#         num_runs_1 = 1
#     else:
#         num_runs_1 = 0
#
#     for x in li:
#         if x != x1:
#             x1 = x
#             num_runs += 1
#             if x1 == 1:
#                 num_runs_1 += 1
#
#     num_runs_0 = num_runs - num_runs_1
#
#     return [num_runs_0, num_runs_1]


def get_li_ups(li):
    """Analyze number of ups for Knuth Runs test.

    Return
    ======
    ups: list of number of ups, whose length is number of runs
    """
    ups = {}
    x = li[0]
    len_run = 1
    num_runs = 1
    for i in li[1: len(li)]:
        if i > x:
            len_run += 1
        else:  # not up, so store the old run, and begin a new run
            ups[num_runs] = len_run
            num_runs += 1
            len_run = 1
        x = i

    ## add the last run
    ups[num_runs] = len_run
    num_runs += 1
    len_run = 1

    ups = list(ups.values())
    return ups


def cal_stat_runs_kunth(ups, mute:bool=True):
    """Calculate statistic of Knuth runs test.

    Attention
    =========
    - The statistic follows chi-square distribution with 6 degrees of freedom.
    """
    r = np.zeros(6).reshape((6, 1))
    for j in range(5):
        r[j][0] = sum([i == j+1 for i in ups])
    r[5][0] = len(ups) - np.sum(r)

    a = np.array([
        [4529.4,9044.9,13568,18091,22615,27892],
        [9044.9,18097,27139,36187,45234,55789],
        [13568,27139,40721,54281,67852,83685],
        [18091,36187,54281,72414,90470,111580],
        [22615,45234,67852,90470,113262,139476],
        [27892,55789,83685,111580,139476,172860]])
    b = np.array([[(1)/(6)], [(5)/(24)], [(11)/(120)], [(19)/(720)],
        [(29)/(5040)],[(1)/(840)]])
    n = sum(ups)

    stat = ( (r - n * b).transpose() @ a @ (r - n * b) )[0][0] / (n - 6)
    if not mute:
        print(f"Knuth runs test: {stat:.4f}.")

    return stat


def get_binary_ud(li):
    li_diff = [li[i+1] - li[i] for i in range(0, len(li) - 1)]
    li_binary = [1 if i >= 0 else 0 for i in li_diff]
    return li_binary


def cal_stat_runs_ud(li, mute:bool=True):
    """Perform Up-and-Down Runs Test

    Attentions
    ==========
    The hypothesis of randomness is rejected when the total number of runs is small.
    """
    if sum( [(i == 1 or i == 0) for i in li] ) != len(li):
        raise ValueError("The input is not a binary list.")

    num_runs = cal_num_runs(li)
    n = len(li)

    mu = (2 * n - 1) / 3
    se = math.sqrt( (16 * n - 29) / 90 )
    stat = (num_runs - mu) / se
    if not mute:
        print(f'Up-and-Down Runs Test: stat = {stat:.4f}.')
        print(f'Number of runs: {num_runs}.')

    return stat


def cal_stat_corr_uniform(li, h:int=1):
    """Calculate statistic of correlation test for samples from two
    independent uniformly distributed random variables.

    Keyword Arguments
    =================
    h: lag used in the correlation test.

    Attention
    =========
    The statistic follows normal distribution.
    """
    n = len(li)
    s = [li[i] * li[i+h] for i in range(n - h)]
    r = sum(s) / (n - h)
    mu = 0.25
    se = math.sqrt( 7 / 144 / n )

    stat = (r - mu) / se
    return stat
