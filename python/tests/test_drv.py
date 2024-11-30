
import unittest

from TidySimStat import *


def infer_dist_samples(samples, num_sim, pmf):
    counts = [samples.count(l) for l in range(num_sim)]
    freqs = [i / num_sim for i in counts]
    stat = cal_stat_gof(freqs, pmf)
    pvalue = cal_pvalue_chi2(stat, df=len(pmf) - 1)
    return infer_dist(pvalue)


def exam_sim(pmf, algo, num_sim:int=100):
    """Test if samples from `algo` can pass KS test."""
    if not callable(algo):
        raise Exception("`algo` should be a function!")

    samples = [algo(pmf) for l in range(num_sim)]
    return infer_dist_samples(samples, num_sim, pmf)


class TestDisRandomVariable(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        ## Set up different probability mass functions for tests.
        ## Values will be created everytime when test functions are called.
        ## That is, they cannot be changed permanently within test functions.
        cls.pmf_1 = [0.1, 0.1, 0.2, 0.4, 0.1, 0.1]
        cls.pmf_2 = [7/16, 1/4, 1/8, 3/16]

        ## Test if `sim_drv_reject` raises `ValueError` when PMF is not
        ## well defined.
        cls.pmf_3 = [0.2, 0.2, 0.2, 0.2]  # not equal to 1
        cls.pmf_4 = [- 0.2, 0.2, 0.2, 0.2, 0.4]  # negative probability
        cls.pmf_5 = [7/16, 1/4, 0, 1/8, 3/16]  # zero probability

    def test_sim_drv_reject(self):
        self.assertTrue(exam_sim(self.pmf_1, sim_drv_reject))
        self.assertTrue(exam_sim(self.pmf_2, sim_drv_reject))

        with self.assertRaises(ValueError):
            sim_drv_reject(self.pmf_3)
            sim_drv_reject(self.pmf_4)
            sim_drv_reject(self.pmf_5)

    def test_sim_drv_alias(self):
        def exam(pmf, num_sim:int=100):
            """Test if samples from alias method can pass KS test."""
            alias = set_alias(pmf)
            samples = [run_alias(alias) for l in range(num_sim)]
            return infer_dist_samples(samples, num_sim, pmf)

        self.assertTrue(exam(self.pmf_1))
        self.assertTrue(exam(self.pmf_1))

        with self.assertRaises(ValueError):
            set_alias(self.pmf_3)
            set_alias(self.pmf_4)
            set_alias(self.pmf_5)

    def test_alias_direct(self):
        
        def exam(pmf:list, num_sim:int=100):
            """Test if samples from direct alias method can pass KS test."""
            f, l = set_alias_direct(pmf)
            samples = [run_alias_direct(f, l) for i in range(num_sim)]
            return infer_dist_samples(samples, num_sim, pmf)

        self.assertTrue(exam(self.pmf_1))
        self.assertTrue(exam(self.pmf_2))

        with self.assertRaises(ValueError):
            set_alias_direct(self.pmf_3)
            set_alias_direct(self.pmf_4)
            set_alias_direct(self.pmf_5)


if __name__ == '__main__':
    print("`cd TidySimStat/src` and `python3 -m unittest tests.test_drv` "
        "should be used during unit tests, or `unittest` cannot find "
        "the package.")
    # unittest.main()
