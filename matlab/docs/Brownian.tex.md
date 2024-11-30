
# Brownian Motion

$$
\mathrm{Pr}(y, t | x) = \frac{1}{\sqrt{2 \pi t}} \exp \left( -\frac{1}{2 t}(y - x)^{2} \right)
$$

$$
\vartheta(t, t+s) = \frac{2}{\pi} \arccos \sqrt{t /(t+s)}
$$

### Exercise 8.1.1

$$
\begin{align}
	\mathrm{Pr}\{B(4) \leq 3| B(0) = 1\} &= \int_{- \infty}^{3} \frac{1}{\sqrt{8 \pi}} \exp{\left(\frac{1}{8} (y - 1)^2 \right)} \\
	&= \frac{\sqrt{8}}{2 \sqrt{\pi}} \left[ \exp{\left(\frac{1}{8} (y - 1)^2 \right)} / y \right] \vert_{- \infty}^{3} \\
	&= \frac{\sqrt{8}}{2 \sqrt{\pi}} \left[ \exp{\left(\frac{1}{8} (3 - 1)^2 \right)} / 3 + \exp{\left(\frac{1}{8} (- \infty - 1)^2 \right)} / \infty \right]
\end{align}
$$

Find the number $c$ to satisfy the following equations:

$$
\begin{align}
	\mathrm{Pr}\{B(9) > c| B(0) = 1\} &= \int_{c}^{\infty} \frac{1}{3 \sqrt{2 \pi}} \exp{\left(\frac{1}{18} (y - 1)^2 \right)} = 0.1 \\
\end{align}
$$

### Exercise 8.1.4

$$
\begin{align}
	& E[B(u) B(u+v) B(u+v+w)] \\
	&= E[B(u) B(u+v) \{B(u+v) + B(u+v+w) - B(u+v)\}] \\
	&= E[B(u) B(u+v) B(u+v) + B(u) B(u+v) \{B(u+v+w) - B(u+v)\}] \\
	&= E[B(u) \{B(u) + B(u+v) - B(u)\}^2 + \alpha] \\
	&= E[B(u)^3 + 2 B(u)^2 \{B(u+v) - B(u)\} + \{B(u+v) - B(u)\}^2 + \alpha] \\
	&= E[2 B(u)^2 \{B(u+v) - B(u)\} + \{B(u+v) - B(u)\}^2 + \alpha] \\
\end{align}
$$

$$
\alpha = B(u) \{B(u) + B(u+v) - B(u)\} \{B(u+v+w) - B(u+v)\}
$$

## Problem 8.2.1

Find the conditional probability that a standard Brownian motion is not zero in the interval $(t, t + b]$ given that it is not zero in the interval $(t, t + a]$, where $0 < a < b$ and $t > 0$.

Event A = a standard Brownian motion is not zero in the interval $(t, t + b]$
Event B = a standard Brownian motion is not zero in the interval $(t, t + a]$
Event A, B = a standard Brownian motion is not zero in the interval $(t, t + b]$

$$
\begin{align}
	\mathrm{Pr}\{A | B\} &= \frac{\mathrm{Pr}\{A, B\}}{\mathrm{Pr}\{B\}} \\
	&= \frac{\vartheta(t, t+b)}{\vartheta(t, t+a)} \\
	&= \frac{\arccos \sqrt{t /(t+b)}}{\arccos \sqrt{t /(t+a)}}
\end{align}
$$

## Problem 8.2.4

$$
\begin{align}
\mathrm{Pr}\{M(t) \geq z, B(t) \leq x \}
&= \mathrm{Pr}\{B(t) \geq 2 z - x \} \\
&= 1 - \Phi\left(\frac{2 z-x}{\sqrt{t}}\right) \quad \text{for } 0<x<m
\end{align}
$$

$$
\begin{align}
\mathrm{Pr}\{M(t) \geq z, B(t) \leq x \}
&= \mathrm{Pr}\{M(t) \geq z | B(t) \leq x \} \mathrm{Pr}\{B(t) \leq x \} \\
&=
\end{align}
$$

$$
\begin{align}
	\mathrm{Pr}\{M(t) \geq z\}
	&= \mathrm{Pr}\{M(t) \geq z | B(t) \leq x \} + \mathrm{Pr}\{M(t) \geq z | x \leq B(t) \leq z \} + \\
	& \qquad \mathrm{Pr}\{M(t) \geq z | z \leq B(t) \leq 2 z - x \} + \mathrm{Pr}\{M(t) \geq z | B(t) \geq 2 z - x \} \\
	&= 2 \mathrm{Pr}\{M(t) \geq z | B(t) > 2 z - x \} + 2 \mathrm{Pr}\{M(t) \geq z | z < B(t) < 2 z - x \} \\
	&= 2 \mathrm{Pr}\{B(t) > 2 z - x | B(\tau) = z\} + 2 \mathrm{Pr}\{z < B(t) < 2 z - x | B(\tau) = z\} \\
	&= 2 \mathrm{Pr}\{B(t) > z | B(\tau) = z\}
\end{align}
$$
