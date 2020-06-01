
from auxiliary import *


def sim_drv_reject(pmf, c):
    """Rejection method to simulate realisations of a discrete random variables
    with `random.random()` and uniform distribution as basis functions.

    Keyworkd Argument
    =================
    pmf: probablity mass function of the desired discrete random variable.

    Attentions
    ==========
    - The possible values of the desired DRV is 1, 2, 3, ..., j.
    - Whenever `p_j` is larger than 0, `q_j` should be larger than 0, or there
      is no way to simulate the realisation being j for the desired
      distribution. For the sake of simplicity, the uniform distribution over
      all possible indices is used as basis random variable.
    """
    n = len(pmf)
    pmf_q = [1 / n for i in range(n)]

    while True:
        y = rd.randint(1, n)
        u = rd.random()
        if u < pmf(y-1) / c / pmf_q(y-1):
            x = y + 0
            break

    return x


def find_ij(p):
    """Find the index i, j in the apas method for generating
    discrete random variables.

    Issues
    ======
    There are many numerical issues. I have tried to solve most of them.
    Details can be found in comments.
    """
    n = len([l for l in p if greater(l, 0)])

    ## Find all indices with their values smaller than 1/(n-1) and
    ## return the first one. Note that p is considered as positive
    ## PMF, so point with 0 probablity is not considered.
    i = [l for l, x in enumerate(p) if less(x, 1 / (n-1)) and greater(x, 0)][0]

    indices = [l for l, x in enumerate(p) if geq(p[i] + x, 1 / (n-1))]
    # Note that the value to compare with must be set as ... - 0.0001
    k = 0
    ## To make sure that j != i
    while indices[k] == i:
        k += 1
    j = indices[k]

    ## It is easy to check the results
    if j == i or geq(p[i], 1 / (n-1)) or less(p[i] + p[j], 1 / (n-1)):
        # Note that the value to compare with must be set as ... - 0.0001
        raise Exception("There is something wrong with the function.")

    ## It is very likely that `p[i]` is larger than `p[j]` in last iterations.
    ## Specifically, when it becomes a two-point PMF, either index can be
    ## chosen as `i`. To prevent `p[i]` is larger, we can simply swap the two.
    if p[i] > p[j]:
        k = i + 0
        i = j + 0
        j = k + 0

    ## The index in Python starts with 0
    i += 1
    j += 1

    return i, j


def set_alias(p):
    """Set up alias for a positive probability mass function.

    Keyword Arguments
    =================
    p: list indicating `n`-point positive PMF

    Local Variables
    ===============
    ps: dict of PMF "p"
    qs: dict of PMF "q"
    qis: dict of `i` values in each iteration
    qjs: dict of `j` values in each iteration

    Issues
    ======
    - Not sure if the `i` and `j` in the final iteration is right.
      For now, the index of the smaller one is assumed to be `i`.
    - Mathematically, `(n-k)` is indicating the number of points
      in the current positive PMF. Sometimes, when there are two
      identical values in the PMF, one iteration can reduce two
      probability points to zero. That way, the PMF in the final
      iteration will have only one point. For example, try PMF
      `[0.1, 0.1, 0.2, 0.4, 0.1, 0.1]`. Besides, it is likely that
      such iterations will happen more than once. So the number of
      necessary iteration may not be `n-1`. This function has been
      formulated in case of that PMF, but I haven't found such
      cases, yet. In theory, such case is not supposed to happen.
      Because, even if it happens, it will not pass the final result
      check.
    """
    check_posi_pmf(p)
    n = len(p)
    ps = {n: [l for l in p]}
    qs = {}
    qis = {}
    qjs = {}

    k = 1
    while True:
        i, j = find_ij(ps[n-k+1])
        qis[k] = i + 0
        qjs[k] = j + 0
        i -= 1  # To make sure that `i` can be used following mathematical expressions
        j -= 1

        qs[k] = [0 for l in range(n)]
        qs[k][i] = (n-k) * ps[n-k+1][i]
        qs[k][j] = 1 - (n-k) * ps[n-k+1][i]
        check_posi_pmf(qs[k])

        ps[n-k] = [(n-k) / (n-k-1) * l for l in ps[n-k+1]]
        ps[n-k][j] = (n-k) / (n-k-1) * (ps[n-k+1][i] + ps[n-k+1][j] - 1/(n-k))
        ps[n-k][i] = 0
        check_posi_pmf(ps[n-k])

        ## `ps[n-k]` should be a {n-k}-point PMF
        if abs( sum(ps[n-k]) - 1 ) > 0.0001:
            raise Exception(f"There is something wrong with {n-k}-point PMF.")

        ## Check the iteration
        q_t = [l / (n-k) for l in qs[k]]
        p_t = [(n-k-1) / (n-k) * l for l in ps[n-k]]
        p_tt = map(add, q_t, p_t)
        t = sum( map(add, ps[n-k+1], [-l for l in p_tt]) )
        if not equal(t, 0):
            print(f"t = {t}.")
            raise Exception("The function is wrong.")

        k += 1
        n_current = len([l for l in ps[n-k+1] if greater(l, 0)])
        if k >= n-1 or n_current <= 1:
            break

    ## Final iteration. `qs[k]` equals ` ps[2]`.
    qs[k] = [l for l in ps[n-k+1]]
    ## It is likely that `i` will equal to `j` because there is one value left.
    if n_current == 1:
        qis[k] = [l for l, x in enumerate(ps[n-k+1]) if greater(x, 0)][0] + 1
        qjs[k] = qis[k] + 0
    else:  # If `i` is not equal to `j`, the procedure is almost the same as before.
        i, j = find_ij(ps[n-k+1])
        qis[k] = i + 0
        qjs[k] = j + 0

    ## Convert the dict to pandas data frame.
    q_pd = pd.DataFrame.from_dict(qs, orient='index')
    q_pd.columns = [l for l in range(1, n+1)]

    ## Check the final result
    p_new = [i / (n-1) for i in q_pd.sum().tolist()]
    delta = map(add, p, [-l for l in p_new])
    t = sum([abs(l) for l in delta])
    if not equal(t, 0):
        print(f"t = {t}.")
        raise Exception("The final result is wrong.")

    ## Add columns containing `i` and `j` information in each iteration.
    ## Note that `pandas.assign` doesn't change the original data frame directly.
    q_pd = q_pd.assign(i=[l for l in qis.values()], j=[l for l in qjs.values()])

    return q_pd


def run_alias(alias):
    n = alias.shape[0] + 1
    int_sim = rd.randint(1, n-1)
    u = rd.random()
    i_sim = alias['i'][int_sim]
    j_sim = alias['j'][int_sim]

    if u < alias[i_sim][int_sim]:
        x = i_sim
    else:
        x = j_sim

    return x