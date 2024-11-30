
import random as rd
import pandas as pd
import math
from typing import Union

from TidySimStat.auxiliary import check_prime
from TidySimStat.drv import sim_drv_reject


def sim_mcmc(x1:Union[int, tuple], f_y, f_accept, n_sample:int):
    """Conduct Markov Chain Monte Carlo simulation.

    Keyword Arguments
    =================
    f_y: function to generate candidate state.
    f_accept: function to decide whether to accept candidate state.
    n_sample: number of samples
    """
    if callable(f_y) is not True:
        raise ValueError(f"Input `f_y` is not callable.")
    if callable(f_accept) is not True:
        raise ValueError(f"Input `f_accept` is not callable.")

    states = {}
    y1 = f_y(x1)
    states[1] = {"x": x1, "y": y1, "whe_accept": 0}

    for n in range(2, n_sample+1):
        x_pre = states[n-1]['x']
        y = f_y(x_pre)
        states[n] = f_accept(x_pre, y)

    return states


def get_ss(sample_space:list) -> dict:
    """Formulate the dictionary containing sample space.

    Attentions
    ==========
    The index of the dictionary starts from 1.
    """
    ss = {}
    n = len(sample_space)
    for i in range(n):
        ss[i+1] = sample_space[i]
    return ss


def get_ss_2d(sample_space:list, shape1:int) -> dict:
    """Formulate the dictionary containing sample space.

    Keyword Arguments
    =================
    sample_space: list of tuples representing possible two-dimensional
                  sample space.
    shape1: size of the first dimension.

    Attentions
    ==========
    The index of the dictionary starts from 1.
    """
    if len([x for x in sample_space if sample_space.count(x) > 1]) != 0:
        raise ValueError(f"There is at least one duplication in the "
            "input sample space.")
    elif check_prime(len(sample_space)):
        raise ValueError(f"The size of the sample space is a prime numner. "
            "This algorithm is not able to handle such sample space.")
    ## Better to shuffle the sample space, though I don't think there will be
    ## any problem if not.
    rd.shuffle(sample_space)

    shape2 = len(sample_space) / shape1
    if not isinstance(shape1, int):
        raise ValueError(f"Size of the first dimension must be integer.")
    elif shape1 < 2:
        raise ValueError(f"Size of the first dimension is at least 2.")
    elif not math.floor(shape2) == math.ceil(shape2):
        raise ValueError(f"Size of the second dimension must be integer.")
    elif shape2 < 2:
        raise ValueError(f"Size of the second dimension is at least 2.")
    shape2 = int(shape2)

    ss = {}
    n = 0
    for i in range(1, shape1 + 1):
        for j in range(1, shape2 + 1):
            ss[(i, j)] = sample_space[n]
            n += 1

    return ss


def loop(x:int, x_max:int) -> int:
    if x > x_max:
        x = 1
    elif x < 1:
        x = x_max + 0
    return x


def loop_rdw_2d(x:tuple, x_max:tuple) -> tuple:
    """2-dimensional random walk with loop.

    Keyword Arguments
    =================
    x: current position
    x_max: maximum possible position

    Returns
    =======
    y: new position
    """
    x1, x2 = x
    y1 = loop_rdw(x1, x_max[0])
    y2 = loop_rdw(x2, x_max[1])
    return (x1_new, x2_new)


def loop_rdw(x:int, x_max:int) -> int:
    """Random walk with loop.

    Keyword Arguments
    =================
    x: current position
    x_max: maximum possible position

    Returns
    =======
    y: new position
    """
    y = x + walk_rd_with0()
    y = loop(y, x_max)
    return y


def walk_rd() -> int:
    delta = -1 if rd.randint(0, 1) == 0 else 1
    return delta


def walk_rd_with0() -> int:
    """Random walk with three possible steps.

    """
    delta = rd.randint(-1, 1)
    return delta


def accept_hm(x_pre:int, y:int, f_b) -> dict:
    """If accept the candidate states in Hastings-Metropolis algorithm

    Keyword Arguments
    =================
    x_pre: current state
    y: candidate state
    f_b: function to calculate the positive number
    """
    if callable(f_b) is not True:
        raise ValueError(f"Input `f_b` is not callable.")

    if f_b(y) >= f_b(x_pre):
        if isinstance(y, tuple):
            x = y + ()
        else:
            x = y + 0
        whe_accept = 1
    elif rd.random() < f_b(y) / f_b(x_pre):
        if isinstance(y, tuple):
            x = y + ()
        else:
            x = y + 0
        whe_accept = 1
    else:
        if isinstance(y, tuple):
            x = y + ()
        else:
            x = x_pre + 0
        whe_accept = 0

    return {'x': x, 'y': y, 'whe_accept': whe_accept}


# def candidate_col_wise():
#     pass


def sample_gibbs(x_pre, num_servers, a):
    """Gibbs sampler for a 2-dimensional Markov Chain Monte Carlo.

    Keyword Arguments
    =================
    x_pre: previous random vector sample
    num_servers:
    as: parameters

    Attentions
    ==========
    - When utilizing the Gibbs sampler, the candidate state is always
      accepted as the next state of the chain.
    - The conditional distributions should be given all determined
      analytically.
    """
    y = (0, 0)

    ## Draw the i-th coordinate to change
    i = rd.randint(0, 1)
    j = 1 - i
    y[j] = x_pre[j]

    xi = x[i]
    xj = x[j]
    ai = a[i]
    aj = a[j]

    ## Defind the new random variable
    numerators = [cal_count_queue(l, ai) for l in range(num_servers - xj + 1)]
    pmf = [l / sum(numerators) for l in numerators]
    y[i] = sim_drv_reject(pmf)

    ## Examine the final result
    if sum(y) < 0 or sum(y) > num_servers:
        raise Exception(f"y = {y} .")

    return y
