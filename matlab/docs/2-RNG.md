



Write a program generating 10.000 (pseudo-) random numbers and

## Cross-Section Data and Time Series

# 1,  Random Number Generator (RNG)

## 1.1,  Fibonacci Generator

## 1.2,  Linear Congruential Generator (LCG)

First implement the LCG yourself by experimenting with different values of “a”, “b” and “c”.

```matlab
function [vec_result, vec_prob] = getRandomNumLCG(mCap, a, c, x0)
    vec_result = zeros(mCap, 1);
    vec_prob = zeros(mCap, 1);
    vec_result(1) = rem(a * x0 + c, mCap);
    for i = 2:mCap
        vec_result(i) = rem(a * vec_result(i-1) + c, mCap);
        vec_prob(i) = vec_result(i) / mCap;
    end
    histogram(vec_result, 10)
end
```

# 2,  Statistical Test of the RNG List

There are two statistical characters of the RNG list, distribution type and randomness, for which some tests are used.

## 2.1,  Test for distribution type

H0: Multi-nominal Distribution [0.1] * 10
H1: [0.1253 0.0625 0.1249 0.1249 0.0625 0.125 0.0624 0.125 0.125 0.0625]

### 2.1.1,  Visual tests/plots

Present these numbers in a histogram (e.g. 10 classes): `histogram(vec_result, 10)`.

## 3. RNG, Population and Sample

> We will think of a sample distribution as a random realization from a population distribution. In the above example, the sample is all newborn children in the UK in 2004, whereas the population distribution is thought of as representing the bio- logical causal mechanism that determines the sex of children. Thus, although the sample here is actually the population of all newborn children in the UK in 2004, the population from which that sample is drawn is a hypothetical one. [_hendry2007econometric_]



---

[_sheldon2012simulation_]: https://github.com/edxu96/symposium/tree/master/src/sim
[_hendry2007econometric_]: https://github.com/edxu96/symposium/tree/master/src/sim
