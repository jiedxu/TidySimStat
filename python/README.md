# Stochastic Simulation in Python

I have written a new package in Python for course [stochastic simulation](http://www2.imm.dtu.dk/courses/02443/) at Technical University of Denmark.

`unittest` package is used primarily to test all the functions for simulations and statistical inferences.

## Notes

- When inter arrival times are simulated by Erlang distribution with mean 1, the blocking rate is expected to be lower. When they are simulated by hyper-exponential distribution (0.8, 0.2) with mean (0.8333, 5), the rate is to be higher.
- When Pareto distribution is used, large amount of samples are needed.
- Variance of blocking rates will vary.
- Common random numbers for different policies. < Each customer should be assigned with same random numbers for random variables for service times and service times. >
- [How do you see a Markov chain is irreducible?](https://stats.stackexchange.com/questions/186033/how-do-you-see-a-markov-chain-is-irreducible)
