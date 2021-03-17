#Key points
#The task of statistical inference is to estimate an unknown population parameter using observed data from a sample.
#In a sampling model, the collection of elements in the urn is called the population.
#A parameter is a number that summarizes data for an entire population.
#A sample is observed data from a subset of the population.
#An estimate is a summary of the observed data about a parameter that we believe is informative. It is a data-driven guess of the population parameter.
#We want to predict the proportion of the blue beads in the urn, the parameter  𝑝 . The proportion of red beads in the urn is  1−𝑝  and the spread is  2𝑝−1 .
#The sample proportion is a random variable. Sampling gives random results drawn from the population distribution.
#Code: Function for taking a random draw from a specific urn
#The dslabs package includes a function for taking a random draw of size  𝑛  from the urn described in the video:
  
library(tidyverse)
library(dslabs)
take_poll(25)    

# `N` represents the number of people polled
N <- 25

# Create a variable `p` that contains 100 proportions ranging from 0 to 1 using the `seq` function
p <- seq(0,1, length = 100)

# Create a variable `se` that contains the standard error of each sample average
se <- sqrt(p * (1 - p)/N)

# Plot `p` on the x-axis and `se` on the y-axis
plot(p,se)

# The vector `p` contains 100 proportions of Democrats ranging from 0 to 1 using the `seq` function
p <- seq(0, 1, length = 100)

# The vector `sample_sizes` contains the three sample sizes
sample_sizes <- c(25, 100, 1000)

# Write a for-loop that calculates the standard error `se` for every value of `p` for each of the three samples sizes `N` in the vector `sample_sizes`. Plot the three graphs, using the `ylim` argument to standardize the y-axis across all three plots.
for(N in sample_sizes){
  se <- sqrt(p*(1-p)/N)
  plot(p, se, ylim = c(0,0.5/sqrt(25)))
}

# `N` represents the number of people polled
N <- 25

# `p` represents the proportion of Democratic voters
p <- 0.45

# Calculate the standard error of the spread. Print this value to the console.
2*sqrt(p*(1-p)/N)


X_hat <- 0.48
se <- sqrt(X_hat*(1-X_hat)/25)
pnorm(0.01/se) - pnorm(-0.01/se)

#Code: Monte Carlo simulation using a set value of p
p <- 0.45    # unknown p to estimate
N <- 1000

# simulate one poll of size N and determine x_hat
x <- sample(c(0,1), size = N, replace = TRUE, prob = c(1-p, p))
x_hat <- mean(x)

# simulate B polls of size N and determine average x_hat
B <- 10000    # number of replicates
N <- 1000    # sample size per replicate
x_hat <- replicate(B, {
  x <- sample(c(0,1), size = N, replace = TRUE, prob = c(1-p, p))
  mean(x)
})

#Code: Histogram and QQ-plot of Monte Carlo results
library(tidyverse)
library(gridExtra)
p1 <- data.frame(x_hat = x_hat) %>%
  ggplot(aes(x_hat)) +
  geom_histogram(binwidth = 0.005, color = "black")
p2 <- data.frame(x_hat = x_hat) %>%
  ggplot(aes(sample = x_hat)) +
  stat_qq(dparams = list(mean = mean(x_hat), sd = sd(x_hat))) +
  geom_abline() +
  ylab("X_hat") +
  xlab("Theoretical normal")
grid.arrange(p1, p2, nrow=1)