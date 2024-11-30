## Bootstrapping of Multi-Variate Time Series
## according to hendry2007econometric
## Edward J. Xu
## Mar 27, 2020
rm(list = ls())
setwd("~/GitHub/TidySimStat/src/MultiVariateTimeSeries")
library(tidyverse)
library(magrittr)
library(mvtnorm)
library(boot)
library(stats)

data(wool)
dat <- wool %>%
  as.numeric() %>%
  {tibble(p = .)} %>%
  mutate(t = row_number()) %>%
  select(t, p)
  
dat %>%
  mutate(p_logmin = log(p) / min(p)) %>%
  ggplot() + geom_line(aes(t, p_logmin))

dat %>%
  mutate(p_lag = .$p - dplyr::lag(.$p))  %>%
  ggplot() + 
    # geom_point(aes(t, p_lag)) +
    geom_segment(aes(t, 0, xend = t, yend = p_lag))

####
library(fpp2)

bootseries <- 
  bld.mbb.bootstrap(debitcards, 10) %>%
  as.data.frame() %>% 
  ts(start=2000, frequency=12)

autoplot(debitcards) +
  autolayer(bootseries, colour=TRUE) +
  autolayer(debitcards, colour=FALSE) +
  ylab("Bootstrapped series") + 
  guides(colour="none")

sim <- bld.mbb.bootstrap(debitcards, 10) %>%
  as.data.frame() %>%
  ts(frequency=12, start=2000)

fc <- purrr::map(as.list(sim), function(x){forecast(ets(x))[["mean"]]}) %>%
  as.data.frame() %>%
  ts(frequency=12, start=start)

autoplot(debitcards) +
  autolayer(sim, colour=TRUE) +
  autolayer(fc, colour=TRUE) +
  autolayer(debitcards, colour=FALSE) +
  ylab("Bootstrapped series") +
  guides(colour="none")