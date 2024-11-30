
from matplotlib import pyplot as plt
import math
import scipy.stats as st

from TidySimStat import sim_exp


def plot_sim_exp():
    """"""
    num_sim = 1000
    expect = 5
    samples = [tss.sim_exp(expect) for i in range(1000)]

    xs = [i for i in range(40)]
    densities = [math.exp(- i / expect) / expect for i in xs]

    fig = plt.figure()
    plt.hist(samples, bins = 20, density=True)
    plt.plot(xs, densities)
    fig.savefig('./plot_sim_exp.png', dpi=fig.dpi)


def plot_sim_pareto():
    num_sim = 1000
    beta = 5
    k = 5
    samples = [tss.sim_pareto(beta, k) for i in range(1000)]

    ## Calculate theoretical values
    xs = [i for i in range(5, 40)]
    densities = [k * (beta)**k / i**(k+1) for i in xs]

    fig = plt.figure()
    plt.hist(samples, bins = 20, density=True)
    plt.plot(xs, densities)
    fig.savefig('./plot_sim_pareto.png', dpi=fig.dpi)


def plot_sim_norm():
    num_sim = 1000
    beta = 5
    k = 5
    samples = [sim_norm() for i in range(1000)]

    ## Calculate theoretical values
    xs = [i / 10 for i in range(-50, 50)]
    densities = [st.norm.pdf(i) for i in xs]

    fig = plt.figure()
    plt.hist(samples, bins = 20, density=True)
    plt.plot(xs, densities)
    fig.savefig('./plot_sim_norm.png', dpi=fig.dpi)


def plot_sim_norm_bm():
    num_sim = 1000
    beta = 5
    k = 5
    samples = [sim_norm_bm()[0] for i in range(1000)]

    ## Calculate theoretical values
    xs = [i / 10 for i in range(-50, 50)]
    densities = [st.norm.pdf(i) for i in xs]

    fig = plt.figure()
    plt.hist(samples, bins = 20, density=True)
    plt.plot(xs, densities)
    fig.savefig('./plot_sim_norm_bm.png', dpi=fig.dpi)
