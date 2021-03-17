# Key points
# Some functions automatically apply element-wise to vectors, such as sqrt() and *.
# However, other functions do not operate element-wise by default. This includes functions we define ourselves.
# The function sapply(x, f) allows any other function f to be applied element-wise to the vector x.

# The probability of an event happening is 1 minus the probability of that event not happening:
  
#   Pr(event)=1−Pr(no event) 
# We can compute the probability of shared birthdays mathematically:
  
#   Pr(shared birthdays)=1−Pr(no shared birthdays)=1−(1×364365×363365×...×365−𝑛+1365) 
# Code: Function for birthday problem Monte Carlo simulations
# Note that the function body of compute_prob() is the code that we wrote in the previous video. If we write this code as a function, we can use sapply() to apply this function to several values of n.

# function to calculate probability of shared bdays across n people
compute_prob <- function(n, B = 10000) {
  same_day <- replicate(B, {
    bdays <- sample(1:365, n, replace = TRUE)
    any(duplicated(bdays))
  })
  mean(same_day)
}

n <- seq(1, 60)

# Code: Element-wise operation over vectors and sapply
x <- 1:10
sqrt(x)    # sqrt operates on each element of the vector

y <- 1:10
x*y    # * operates element-wise on both vectors

compute_prob(n)    # does not iterate over the vector n without sapply

x <- 1:10
sapply(x, sqrt)    # this is equivalent to sqrt(x)

prob <- sapply(n, compute_prob)    # element-wise application of compute_prob to n
plot(n, prob)

# Code: Computing birthday problem probabilities with sapply
# function for computing exact probability of shared birthdays for any n
exact_prob <- function(n){
  prob_unique <- seq(365, 365-n+1)/365   # vector of fractions for mult. rule
  1 - prod(prob_unique)    # calculate prob of no shared birthdays and subtract from 1
}

# applying function element-wise to vector of n values
eprob <- sapply(n, exact_prob)

# plotting Monte Carlo results and exact probabilities on same graph
plot(n, prob)    # plot Monte Carlo results
lines(n, eprob, col = "red")    # add line for exact prob