#Textbook link
#This video corresponds to the textbook section on Bayes' Theorem External link.

#Key points
#Bayes' Theorem states that the probability of event A happening given event B is equal to the probability of both A and B divided by the probability of event B:
#  Pr(𝐴∣𝐵)=Pr(𝐵∣𝐴)Pr(𝐴)Pr(𝐵) 
#Bayes' Theorem shows that a test for a very rare disease will have a high percentage of false positives even if the accuracy of the test is high.
#Equations: Cystic fibrosis test probabilities
#In these probabilities, + represents a positive test, - represents a negative test,  𝐷=0  indicates no disease, and  𝐷=1  indicates the disease is present.

#Probability of having the disease given a positive test:  Pr(𝐷=1∣+) 
#99% test accuracy when disease is present:  Pr(+∣𝐷=1)=0.99 
#99% test accuracy when disease is absent:  Pr(−∣𝐷=0)=0.99 
#Rate of cystic fibrosis:  Pr(𝐷=1)=0.00025 
#Bayes' theorem can be applied like this:
  
#  Pr(𝐷=1∣+)=Pr(+∣𝐷=1)⋅Pr(𝐷=1)Pr(+) 
#Pr(𝐷=1∣+)=Pr(+∣𝐷=1)⋅Pr(𝐷=1)Pr(+∣𝐷=1)⋅Pr(𝐷=1)+Pr(+∣𝐷=0)⋅Pr(𝐷=0) 
#Substituting known values, we obtain:
  
#  0.99⋅0.000250.99⋅0.00025+0.01⋅0.99975=0.02 

#Code: Monte Carlo simulation
prev <- 0.00025    # disease prevalence
N <- 100000    # number of tests
outcome <- sample(c("Disease", "Healthy"), N, replace = TRUE, prob = c(prev, 1-prev))

N_D <- sum(outcome == "Disease")    # number with disease
N_H <- sum(outcome == "Healthy")    # number healthy

# for each person, randomly determine if test is + or -
accuracy <- 0.99
test <- vector("character", N)
test[outcome == "Disease"] <- sample(c("+", "-"), N_D, replace=TRUE, prob = c(accuracy, 1-accuracy))
test[outcome == "Healthy"] <- sample(c("-", "+"), N_H, replace=TRUE, prob = c(accuracy, 1-accuracy))

table(outcome, test)


# Load the libraries and poll data
library(dplyr)
library(dslabs)
data(polls_us_election_2016)

# Create an object `polls` that contains the spread of predictions for each candidate in Florida during the last polling days
polls <- polls_us_election_2016 %>% 
  filter(state == "Florida" & enddate >= "2016-11-04" ) %>% 
  mutate(spread = rawpoll_clinton/100 - rawpoll_trump/100)


#
# Define the variables from previous exercises
mu <- 0
sigma <- results$se
Y <- results$avg

# Define a variable `taus` as different values of tau
taus <- seq(0.005, 0.05, len = 100)

# Create a function called `p_calc` that generates `B` and calculates the probability of the spread being less than 0
p_calc <- function(tau){
  B <- sigma^2 / (sigma^2 + tau^2)
  pnorm(0, B*mu + (1-B)*Y, sqrt( 1/ (1/sigma^2 + 1/tau^2)))
}

# Create a vector called `ps` by applying the function `p_calc` across values in `taus`
ps <- p_calc(taus)

# Plot `taus` on the x-axis and `ps` on the y-axis
plot(taus, ps)


# Examine the `polls` object using the `head` function
head(polls)

# Create an object called `results` that has two columns containing the average spread (`avg`) and the standard error (`se`). Print the results to the console.
results <- polls %>% summarize(avg=mean(spread), se=sd(spread)/sqrt(n()))
print(results)