
import math
from itertools import count, islice


def check_prime(n:int) -> bool:
    """Check if input integer is a prime number.

    Notes
    =====
    - https://stackoverflow.com/a/27946768/10181743
    """
    bool_prime = n > 1 and all(n%i for i in islice(count(2),
        int(math.sqrt(n)-1)))
    return bool_prime


def pmf2cdf(pmf):
    """Obtain cumulative distribution function of a discrete random
    variable according to its probablity mass function."""
    k = len(pmf)
    cdf = [pmf[0] for i in range(k)]
    for i in range(1, k):
        cdf[i] = pmf[i] + cdf[i-1]
    return cdf


def cdf2pmf(cdf, ends):
    """Get probability mass function according to the cumulative distribution
    function of a continuous random variable and given list of left ends.

    Attentions
    ==========
    Length of the PMF equals the length of `ends`.
    """
    li_cdf = [f(i) for i in ends]
    pmf = [li_cdf[0]] + [li_cdf[i] - li_cdf[i-1] for i in
        range(1, len(li_cdf))]

    return pmf


def check_posi_pmf(li:list, if_mute=True):
    """Check if input probability mass function represented by a list is
    a `n`-point positive probability mass function."""
    if sum([i <= -0.0001 for i in li]) > 0:
        print(li)
        raise ValueError("Some probability is not positive.")
    elif abs(sum(li) - 1) >= 0.001:
        raise ValueError(f"Sum of PMF {sum(li):.4f} is not 100%.")
    elif not if_mute:
        print(f"The input is a {len(li)}-point positive PMF.")


def greater(x:float, a:float, epsilon:float=0.0001):
    whe_true = x > a + epsilon
    return whe_true


def less(x:float, a:float, epsilon:float=0.0001):
    whe_true = x < a - epsilon
    return whe_true


def geq(x:float, a:float, epsilon:float=0.0001):
    whe_true = x > a - epsilon
    return whe_true


def leq(x:float, a:float, epsilon:float=0.0001):
    whe_true = x < a + epsilon
    return whe_true


def equal(x:float, a:float, epsilon:float=0.0001):
    whe_true = abs(x - a) < epsilon
    return whe_true
