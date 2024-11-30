
import unittest

from TidySimStat.estimation import *



class TestInference(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        ## Set the seed to make tests reproducible.
        ## Note that some tests might fail when the seed is modified.
        # rd.seed(123)
        cls.li_1 = [17, 21, 20, 18, 19, 22, 20, 21, 16, 19]
        cls.li_2 = [16,0,0,2,3,6,8,2,5,0,12,10,5,7,2,3,8,17,9,1]

    def test_est_interval(self):
        ## When the population variance is specified
        interval = est_interval(self.li_1, alpha=0.05, var_pop=9)
        interval = [round(i, 2) for i in interval]
        self.assertEqual(interval, [17.44, 21.16])

        interval = est_interval(self.li_2, alpha=0.05)
        interval = [round(i, 2) for i in interval]
        self.assertEqual(interval, [3.42, 8.18])
