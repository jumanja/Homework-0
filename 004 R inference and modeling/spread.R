#Key points
#An extremely large poll would theoretically be able to predict election results almost perfectly.
#These sample sizes are not practical. In addition to cost concerns, polling doesn't reach everyone in the population (eventual voters) with equal probability, and it also may include data from outside our population (people who will not end up voting).
#These systematic errors in polling are called bias. We will learn more about bias in the future.
#Code: Plotting margin of error in an extremely large poll over a range of values of p
library(tidyverse)
N <- 100000
p <- seq(0.35, 0.65, length = 100)
SE <- sapply(p, function(x) 2*sqrt(x*(1-x)/N))
data.frame(p = p, SE = SE) %>%
    ggplot(aes(p, SE)) +
    geom_line()

# Write a function called `take_sample` that takes `p` and `N` as arguements and returns the average value of a randomly sampled population.

take_sample<- function(p, N){
  data <- sample(c(0,1), size= N, replace= TRUE,  prob= c(1 - p, p))
  mean(data)
}



# Use the `set.seed` function to make sure your answer matches the expected result after random sampling
set.seed(1)

# Define `p` as the proportion of Democrats in the population being polled
p <- 0.45

# Define `N` as the number of people polled
N <- 100

# Call the `take_sample` function to determine the sample average of `N` randomly selected people from a population containing a proportion of Democrats equal to `p`. Print this value to the console.
take_sample(p, N)

#Code: geom_smooth confidence interval example
#The shaded area around the curve is related to the concept of confidence intervals.

data("nhtemp")
data.frame(year = as.numeric(time(nhtemp)), temperature = as.numeric(nhtemp)) %>%
  ggplot(aes(year, temperature)) +
  geom_point() +
  geom_smooth() +
  ggtitle("Average Yearly Temperatures in New Haven")

#Code: Monte Carlo simulation of confidence intervals
#Note that to compute the exact 95% confidence interval, we would use qnorm(.975)*SE_hat instead of 2*SE_hat.

p <- 0.45
N <- 1000
X <- sample(c(0,1), size = N, replace = TRUE, prob = c(1-p, p))    # generate N observations
X_hat <- mean(X)    # calculate X_hat
SE_hat <- sqrt(X_hat*(1-X_hat)/N)    # calculate SE_hat, SE of the mean of N observations
c(X_hat - 2*SE_hat, X_hat + 2*SE_hat)    # build interval of 2*SE above and below mean

#Code: Solving for  𝑧  with qnorm
z <- qnorm(0.995)    # calculate z to solve for 99% confidence interval
pnorm(qnorm(0.995))    # demonstrating that qnorm gives the z value for a given probability
pnorm(qnorm(1-0.995))    # demonstrating symmetry of 1-qnorm
pnorm(z) - pnorm(-z)    # demonstrating that this z value gives correct probability for interval


#Key points
#We can run a Monte Carlo simulation to confirm that a 95% confidence interval contains the true value of  𝑝  95% of the time.

#A plot of confidence intervals from this simulation demonstrates that most intervals include  𝑝 , but roughly 5% of intervals miss the true value of  𝑝 .
#Code: Monte Carlo simulation
#Note that to compute the exact 95% confidence interval, we would use qnorm(.975)*SE_hat instead of 2*SE_hat.

B <- 10000
inside <- replicate(B, {
  X <- sample(c(0,1), size = N, replace = TRUE, prob = c(1-p, p))
  X_hat <- mean(X)
  SE_hat <- sqrt(X_hat*(1-X_hat)/N)
  between(p, X_hat - 2*SE_hat, X_hat + 2*SE_hat)    # TRUE if p in confidence interval
})
mean(inside)

#Key points
#If we are trying to predict the result of an election, then a confidence interval that includes a spread of 0 (a tie) is not helpful.
#A confidence interval that includes a spread of 0 does not imply a close election, it means the sample size is too small.
#Power is the probability of detecting an effect when there is a true effect to find. Power increases as sample size increases, because larger sample size means smaller standard error.
#Code: Confidence interval for the spread with sample size of 25
#Note that to compute the exact 95% confidence interval, we would use c(-qnorm(.975), qnorm(.975)) instead of 1.96.

N <- 25
X_hat <- 0.48
(2*X_hat - 1) + c(-2, 2)*2*sqrt(X_hat*(1-X_hat)/N)


#Key points
#The null hypothesis is the hypothesis that there is no effect. In this case, the null hypothesis is that the spread is 0, or  𝑝=0.5 .

#The p-value is the probability of detecting an effect of a certain size or larger when the null hypothesis is true.
#We can convert the probability of seeing an observed value under the null hypothesis into a standard normal random variable. We compute the value of  𝑧  that corresponds to the observed result, and then use that  𝑧  to compute the p-value.
#If a 95% confidence interval does not include our observed value, then the p-value must be smaller than 0.05.
#It is preferable to report confidence intervals instead of p-values, as confidence intervals give information about the size of the estimate and p-values do not.
#Code: Computing a p-value for observed spread of 0.02
N <- 100    # sample size
z <- sqrt(N) * 0.02/0.5    # spread of 0.02
1 - (pnorm(z) - pnorm(-z))

Code: Generating simulated poll data
library(dslabs)
data(polls_us_election_2016)
names(polls_us_election_2016)

# keep only national polls from week before election with a grade considered reliable
polls <- polls_us_election_2016 %>%
  filter(state == "U.S." & enddate >= "2016-10-31" &
           (grade %in% c("A+", "A", "A-", "B+") | is.na(grade)))

# add spread estimate
polls <- polls %>%
  mutate(spread = rawpoll_clinton/100 - rawpoll_trump/100)

# compute estimated spread for combined polls
d_hat <- polls %>%
  summarize(d_hat = sum(spread * samplesize) / sum(samplesize)) %>%
  .$d_hat

# compute margin of error
p_hat <- (d_hat+1)/2
moe <- 1.96 * 2 * sqrt(p_hat*(1-p_hat)/sum(polls$samplesize))

# histogram of the spread
polls %>%
  ggplot(aes(spread)) +
  geom_histogram(color="black", binwidth = .01)
Code: Investigating poll data and pollster bias
# number of polls per pollster in week before election
polls %>% group_by(pollster) %>% summarize(n())

# plot results by pollsters with at least 6 polls
polls %>% group_by(pollster) %>%
  filter(n() >= 6) %>%
  ggplot(aes(pollster, spread)) +
  geom_point() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

# standard errors within each pollster
polls %>% group_by(pollster) %>%
  filter(n() >= 6) %>%
  summarize(se = 2 * sqrt(p_hat * (1-p_hat) / median(samplesize)))