#Key points
#duplicated() takes a vector and returns a vector of the same length with TRUE for any elements that have appeared previously in that vector.
#We can compute the probability of shared birthdays in a group of people by modeling birthdays as random draws from the numbers 1 through 365. We can then use this sampling model of birthdays to run a Monte Carlo simulation to estimate the probability of shared birthdays.
#Code: The birthday problem
# checking for duplicated bdays in one 50 person group
n <- 50
bdays <- sample(1:365, n, replace = TRUE)    # generate n random birthdays
any(duplicated(bdays))    # check if any birthdays are duplicated

# Monte Carlo simulation with B=10000 replicates
B <- 10000
results <- replicate(B, {    # returns vector of B logical values
  bdays <- sample(1:365, n, replace = TRUE)
  any(duplicated(bdays))
})
mean(results)    # calculates proportion of groups with duplicated bdays