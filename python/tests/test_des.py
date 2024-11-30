
import unittest

from TidySimStat.des import *
from TidySimStat.crv import sim_exp


class TestDisEventSim(unittest.TestCase):

    def setUp(self):
        self.ser = Servers(lambda: sim_exp(5), lambda: sim_exp(5), 10)

    def test_warmup(self):
        indices = self.ser.collect()
        self.assertEqual(len(indices), 1)
        self.assertEqual(self.ser.num, 10)

    def test_schedule_arrival(self):
        """Test if to schedule the second arrival and return its index."""
        new = self.ser.schedule_arrival()

        indices = self.ser.collect()
        self.assertEqual(len(indices), 2)

        self.assertEqual(self.ser._next._next._index, new._index)

    def test_undock(self):
        """Test if to undock the first node and return it."""
        t_first = self.ser._next._index
        self.ser.schedule_arrival()
        undocked = self.ser.undock()

        indices = self.ser.collect()
        self.assertEqual(len(indices), 1)

        self.assertEqual(undocked._index, t_first)

    def test_insert(self):
        self.ser.insert(Arrival(time=100))
        self.assertEqual(self.ser._next._next._index, 100)
        self.ser.insert(Arrival(time=98))
        self.assertEqual(self.ser._next._next._index, 98)
        self.ser.insert(Arrival(time=99))
        self.assertEqual(self.ser._next._next._index, 98)

    def test_arrive(self):
        self.ser.arrive()
        self.assertEqual(self.ser.num_arrival, 1)
        self.assertEqual(self.ser.num_block, 0)
        self.assertEqual(self.ser.states[0], 1)
        self.assertEqual(self.ser.first_idle, 1)

        indices = self.ser.collect()
        self.assertEqual(len(indices), 3)

        self.assertEqual(len(self.ser.arriveds), 1)

    def test_advance(self):
        self.ser.advance()
        self.assertEqual(self.ser.num_arrival, 1)
        self.assertEqual(self.ser.num_block, 0)
        self.assertEqual(self.ser.states[0], 1)
        self.assertEqual(self.ser.first_idle, 1)

        indices = self.ser.collect()
        self.assertEqual(len(indices), 2)
        self.assertNotEqual(type(self.ser._next), type(self.ser._next._next))


    # def test_leave(self):
    #     self.ser.arrive()
    #     self.ser.leave()
    #     self.assertEqual(self.ser.states[0], 0)
