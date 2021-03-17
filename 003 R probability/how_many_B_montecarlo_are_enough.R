# Key points
# The larger the number of Monte Carlo replicates  𝐵 , the more accurate the estimate.
# Determining the appropriate size for  𝐵  can require advanced statistics.
# One practical approach is to try many sizes for  𝐵  and look for sizes that provide stable estimates.
# Code: Estimating a practical value of B
# This code runs Monte Carlo simulations to estimate the probability of shared birthdays using several B values and plots the results. When B is large enough that the estimated probability stays stable, then we have selected a useful value of B.

B <- 10^seq(1, 5, len = 100)    # defines vector of many B values
compute_prob <- function(B, n = 22){    # function to run Monte Carlo simulation with each B
  same_day <- replicate(B, {
    bdays <- sample(1:365, n, replace = TRUE)
    any(duplicated(bdays))
  })
  mean(same_day)
}

prob <- sapply(B, compute_prob)    # apply compute_prob to many values of B
plot(log10(B), prob, type = "l")    # plot a line graph of estimates 