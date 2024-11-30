
import pandas as pd


def rng(num:int=1, cal_y=None, m:int=123, x0:int=1):
    """Generic function for random number generator.

    Keyword Arguments
    =================
    num: size of random number vector to generate
    cal_y: function to calculate `y` based on previous `x`
    m: chosen large number, which should be as large as possible
    x0: seed
    """
    if not callable(cal_y):
        raise ValueError("`cal_y` is not a function!")

    rns = {0: {'x': x0, 'y': None, 'u': None}}
    x = x0

    for i in range(1, num+1):
        y1 = cal_y(x)
        x1 = y1 % m
        u1 = x1 / m
        rns.update({i: {'x': x1, 'y': y1, 'u': u1}})
        x = x1

    del rns[0]

    return rns


def rng_lcg(num:int=1, a:int=5, c:int=1, m:int=123, x0:int=1):
    """Linear Congruential Generator (LCG)

    Keyword Arguments
    =================
    a: multiplier
    c: shift
    m: modulus
    """
    cal_y = lambda x: a * x + c
    rns = rng(num, cal_y, m, x0)
    pd_rn = pd.DataFrame.from_dict(rns, orient='index')
    rn = pd_rn['u'].tolist()
    return rn, pd_rn


def rng_fib(num:int=1, x0:int=1, x1:int=1, m:int=123):
    """Fibonacci Generator to generate random number series.

    Keyword Arguments
    =================
    num: size of random number vector to generate
    x0: a seed
    x1: another seed
    m: chosen large number, which should be as large as possible

    Returns
    =======
    rn: list of simulated random numbers
    pd_rn: pandas data frame containing details
    """
    rns = {0: {'x': x0, 'y': None, 'u': None},
        1: {'x': x1, 'y': None, 'u': None}}
    x_1 = x0
    x_2 = x1

    for i in range(1, num+1):
        y1 = x_1 + x_2
        x1 = y1 % m
        u1 = x1 / m
        rns.update({i: {'x': x1, 'y': y1, 'u': u1}})
        x_1 = x1
        x_2 = x_1

    del rns[0], rns[1]
    pd_rn = pd.DataFrame.from_dict(rns, orient='index')
    rn = pd_rn['u'].tolist()

    return rn, pd_rn
