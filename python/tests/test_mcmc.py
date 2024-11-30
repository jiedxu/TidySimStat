
import unittest
import math

from TidySimStat.mcmc import *
from TidySimStat.des_queue import cal_count_queue


def cal_block_rate_2d(n_servers:int, a1:float, a2:float, n_sample:int=10000):
    """Calculate 2-D block rate given by Erlang-B formula using MCMC.

    """
    if n_servers != 10:
        raise ValueError(f"The number of servers must be set as 10 for now.")

    ## Store all possible values in a list
    li = []
    for i in range(0, n_servers + 1):
        li += [(i, j) for j in range(0, n_servers + 1)]

    ## Drop those tuples violating constraints
    li = [x for x in li if x[0] + x[1] <= n_servers]

    ## When `n_servers` is 10, the size of `li` is 66.
    shape1 = 6
    ss = get_ss_2d(li, shape1)
    shape2 = 11

    f_y = lambda x: loop_rdw_2d(x, shape1, shape2)

    def f_b(x):
        i, j = ss[x]
        result = a1**i * a2**j / math.factorial(i) / math.factorial(j)
        return result

    f_accept = lambda x, y: accept_hm(x, y, f_b)

    xz1 = (rd.randint(1, shape1+1), rd.randint(1, shape1+2))
    results = sim_mcmc(xz1, f_y, f_accept, n_sample)

    x_results = [results[i]['x'] for i in
        range(0.05 * n_sample + 1, n_sample + 1)]
    counts = {}
    freqs = {}
    for t in li:
        c = x_results.count(t)
        counts[t] = c
        freqs[t] = c / (0.95 * n_sample)

    return freqs


def cal_block_rate(n_servers:int, a, n_sample:int=10000):
    """Calculate block rate given by Erlang-B formula using MCMC.

    """
    ss = get_ss([i for i in range(0, n_servers+1)])

    f_y = lambda x_pre: loop_walk_rd(x_pre, 1, max(ss.keys()))
    ## Note that the value in sample space must be used to calculate.
    f_b = lambda x: cal_count_queue(ss[x], a)

    def f_accept(x_pre, y):
        if x_pre < 0:
            raise ValueError(f"x_pre = {x_pre} < 0 .")
        elif y < 0:
            raise ValueError(f"y = {y} < 0 .")
        else:
            d = accept_hm(x_pre, y, f_b)

        return d

    x1 = rd.randint(1, n_servers+1)
    states = sim_mcmc(x1, f_y, f_accept, n_sample)

    results = pd.DataFrame.from_dict(states, orient='index')
    results.drop([i for i in range(1, math.floor(0.05 * n_sample))],
        inplace=True)

    counts = [results['x'].tolist().count(i) for i in range(1, n_servers+2)]
    freqs = [counts[i] / sum(counts) for i in range(n_servers+1)]
    return freqs


class TestMCMC(unittest.TestCase):

    def test_sim_mcmc(self):
        n_sample = 10000
        n_servers = 10
        cal_block_rate(n_servers, 8, n_sample)

    def test_get_ss_2d(self):
        sample_space = [(1, 2), (2, 2), (4, 5), (4, 6)]
        pass

    def test_sim_mcmc_2d(self):
        n_sample = 10000
        n_servers = 10
        pass
