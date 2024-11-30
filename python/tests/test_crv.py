
import unittest
import math
import scipy.stats as st
import random as rd

from TidySimStat.crv import *
from TidySimStat.inference import cal_stat_ks, cal_pvalue_ks, infer_dist


def exam_sim(f_sim, cdf, num_sim:int=1000):
    rd.seed(123)
    samples = [f_sim() for i in range(num_sim)]
    stat = cal_stat_ks(samples, cdf)
    pvalue = cal_pvalue_ks(stat, num_sim)
    return infer_dist(pvalue)


class TestConRandomVariable(unittest.TestCase):

    def test_sim_exp(self):

        def exam(expect=5):
            f_sim = lambda: sim_exp(expect)
            cdf = lambda x: 1 - math.exp(- x / expect)
            return exam_sim(f_sim, cdf)

        self.assertTrue(exam(5))
        self.assertTrue(exam(50))

    def test_sim_pareto(self):

        def exam(beta=5, k=5):
            f_sim = lambda: sim_pareto(beta, k)
            cdf = lambda x: 1 - (beta / x)**k
            return exam_sim(f_sim, cdf)

        self.assertTrue(exam(5, 5))

    def test_sim_norm(self):
        def exam(beta=5, k=5):
            f_sim = lambda: sim_norm()
            cdf = st.norm.cdf
            return exam_sim(f_sim, cdf)

        self.assertTrue(exam(5, 5))

    def test_sim_norm_bm(self):
        def exam(beta=5, k=5):
            ## Note that `sim_norm_bm()` will return outcomes from two
            ## different variables
            f_sim = lambda: sim_norm_bm()[0]
            cdf = st.norm.cdf
            return exam_sim(f_sim, cdf)

        self.assertTrue(exam(5, 5))


if __name__ == '__main__':
    print("`cd TidySimStat/src` and `python3 -m unittest tests.test_crv` "
        "should be used during unit tests, or `unittest` cannot find "
        "the package.")
    # unittest.main()
