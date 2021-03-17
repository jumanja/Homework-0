#Textbook links
#This video corresponds to the textbook section on data-driven models External link.

#Key points
#Instead of using an urn model where each poll is a random draw from the same distribution of voters, we instead define a model using an urn that contains poll results from all possible pollsters.
#We assume the expected value of this model is the actual spread  𝑑=2𝑝−1 .
#Our new standard error  𝜎  now factors in pollster-to-pollster variability. It can no longer be calculated from  𝑝  or  𝑑  and is an unknown parameter.
#The central limit theorem still works to estimate the sample average of many polls  𝑋1,...,𝑋𝑁  because the average of the sum of many random variables is a normally distributed random variable with expected value  𝑑  and standard error  𝜎/𝑁‾‾√ .
#We can estimate the unobserved  𝜎  as the sample standard deviation, which is calculated with the sd function.
#Code 
#Note that to compute the exact 95% confidence interval, we would use qnorm(.975) instead of 1.96.

# collect last result before the election for each pollster
one_poll_per_pollster <- polls %>% group_by(pollster) %>%
  filter(enddate == max(enddate)) %>%      # keep latest poll
  ungroup()

# histogram of spread estimates
one_poll_per_pollster %>%
  ggplot(aes(spread)) + geom_histogram(binwidth = 0.01)

# construct 95% confidence interval
results <- one_poll_per_pollster %>%
  summarize(avg = mean(spread), se = sd(spread)/sqrt(length(spread))) %>%
  mutate(start = avg - 1.96*se, end = avg + 1.96*se)
round(results*100, 1)



# Define `mu` as the population average
mu <- mean(x)

# Use the `set.seed` function to make sure your answer matches the expected result after random sampling
set.seed(1)

# Define `N` as the number of people measured
N <- 50

# Define `B` as the number of times to run the model
B <- 10000

# Define an object `res` that contains a logical vector for simulated intervals that contain mu
res <- replicate(B, {
  X <- sample(x, N, replace = TRUE)
  X_hat <- mean(X)
  se_hat <- sd(X)
  se <- se_hat / sqrt(N)
  interval <- c(qnorm(0.025, mean(X), se) , qnorm(0.975, mean(X), se))
  between(mu, interval[1], interval[2])
})

# Calculate the proportion of results in `res` that include mu. Print this value to the console.
mean(res)


# Create an object called `sigma` that contains a column for `pollster` and a column for `s`, the standard deviation of the spread
polls %>% group_by(pollster)
sigma <- polls %>% group_by(pollster) %>% summarize(s = sd(spread))


# Create an object called `res` that summarizes the average, standard deviation, and number of polls for the two pollsters.
res <- polls %>% group_by(pollster) %>% summarize(avg=mean(spread), s = sd(spread), N=n())
res

Code: Definition of results object
This code from previous videos defines the results object used for empirical Bayes election forecasting.

library(tidyverse)
library(dslabs)
polls <- polls_us_election_2016 %>%
  filter(state == "U.S." & enddate >= "2016-10-31" &
           (grade %in% c("A+", "A", "A-", "B+") | is.na(grade))) %>%
  mutate(spread = rawpoll_clinton/100 - rawpoll_trump/100)

one_poll_per_pollster <- polls %>% group_by(pollster) %>%
  filter(enddate == max(enddate)) %>%
  ungroup()

results <- one_poll_per_pollster %>%
  summarize(avg = mean(spread), se = sd(spread)/sqrt(length(spread))) %>%
  mutate(start = avg - 1.96*se, end = avg + 1.96*se)
#Code: Computing the posterior mean, standard error, credible interval and probability
#Note that to compute an exact 95% credible interval, we would use qnorm(.975) instead of 1.96.

mu <- 0
tau <- 0.035
sigma <- results$se
Y <- results$avg
B <- sigma^2 / (sigma^2 + tau^2)
posterior_mean <- B*mu + (1-B)*Y
posterior_se <- sqrt(1 / (1/sigma^2 + 1/tau^2))

posterior_mean
posterior_se

# 95% credible interval
posterior_mean + c(-1.96, 1.96)*posterior_se

# probability of d > 0
1 - pnorm(0, posterior_mean, posterior_se)
