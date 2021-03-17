library(dslabs)
data(murders)
sort(murders$total)

x <- c(31, 4, 15, 92, 65)
x
sort(x)    # puts elements in order

index <- order(x)    # returns index that will put x in order
x[index]    # rearranging by this index puts elements in order
order(x)

murders$state[1:10]
murders$abb[1:10]

index <- order(murders$total)
murders$abb[index]    # order abbreviations by total murders

max(murders$total)    # highest number of total murders
i_max <- which.max(murders$total)    # index with highest number of murders
murders$state[i_max]    # state name with highest number of total murders

x <- c(31, 4, 15, 92, 65)
x
rank(x)    # returns ranks (smallest to largest)

high_murders <- c(murders$state[which.max(murders$total)], max(murders$total))
low_murders <- c(murders$state[which.max(murders$total)], min(murders$total))

# get a vector of murder_rate wuth the calculation for each row
murder_rate <- murders$total/murders$population*100000

# show state column, order by murder_rate in decreasing order
murders$state[order(murder_rate, decreasing = TRUE)]

# See what states have 0.71 or less of murder_rate
index <- murder_rate < 0.71
index
murders$state[index]

# How many states
sum(index)

# Now create two logical vectors to use them as conditions
west <- murders$region == 'West'
safe <- murder_rate < 1
index <- safe & west
murders$state[index]


# index using which
index <- which(murders$state == "Massachusetts")
index
murder_rate[index]

#The same using without the use of which, but so, index object is going to be larger

# Now match, to get coincidences (like extracting the indexes of rows matching the conditions)
index <- match(c("New York", "Florida", "Texas"), murders$state)
index
murders$state[index]
murder_rate[index]

# %in% just says if it is inside or not
x <- c("a", "b", "c", "d", "e")
y <- c("a", "d", "f")
y %in% x

# to see if Boston, Dakota, and Washington are states
c("Boston", "Dakota", "Washington") %in% murders$state


#Basic Wrangling tools.
library(dplyr)

#add a column to a data frame
str(murders)
murders <- mutate(murders, rate=total/population*100000)
str(murders)
head(murders)

#filter by rate
filter(murders, rate < 0.71)
str(murders)

#new table using select
new_table <- select(murders,state,region,rate)
new_table
filter(new_table, rate < 0.71)

# Now the same but avoiding extra new _table object
murders %>% select(state, region, rate) %>% filter(rate <= 0.71)

# creating a data frame with stringAsFactors = FALSE
grades <- data.frame(names = c("John", "Juan", "Jean", "Yao"), 
                     exam_1 = c(95, 80, 90, 85), 
                     exam_2 = c(90, 85, 85, 90),
                     stringsAsFactors = FALSE)
grades

# a simple scatterplot of total murders versus population
x <- murders$population /10^6
y <- murders$total
plot(x, y)

# a histogram of murder rates
hist(murders$rate)

# boxplots of murder rates by region
boxplot(rate~region, data = murders)

# conditionals
ind <- which.min(murder_rate)
if(murder_rate[ind] < 0.5){
  print(murders$state[ind])
}else{
  print("No state has murder rate that low")
}

# the ifelse() function works similarly to an if-else conditional
a <- 0
ifelse(a > 0, 1/a, NA)

# example of defining a function to compute the average of a vector x
avg <- function(x){
  s <- sum(x)
  n <- length(x)
  s/n
}

# we see that the above function and the pre-built R mean() function are identical
x <- 1:100
identical(mean(x), avg(x))

# variables inside a function are not defined in the workspace
s <- 3
avg(1:10)
s

# the general form of a function
#my_function <- function(VARIABLE_NAME){
#  perform operations on VARIABLE_NAME and calculate VALUE
#  VALUE
#}

# functions can have multiple arguments as well as default values
avg <- function(x, arithmetic = TRUE){
  n <- length(x)
  ifelse(arithmetic, sum(x)/n, prod(x)^(1/n))
}
# the ifelse() function is particularly useful on vectors
a <- c(0,1,2,-4,5)
result <- ifelse(a > 0, 1/a, NA)

# the ifelse() function is also helpful for replacing missing values
data(na_example)
no_nas <- ifelse(is.na(na_example), 0, na_example) 
sum(is.na(no_nas))

# the any() and all() functions evaluate logical vectors
z <- c(TRUE, TRUE, FALSE)
any(z)
all(z)

# creating a function that computes the sum of integers 1 through n
compute_s_n <- function(n){
  x <- 1:n
  sum(x)
}

# a very simple for-loop
for(i in 1:5){
  print(i)
}

# a for-loop for our summation
m <- 25
s_n <- vector(length = m) # create an empty vector
for(n in 1:m){
  s_n[n] <- compute_s_n(n)
}

# creating a plot for our summation function
n <- 1:m
plot(n, s_n)

# a table of values comparing our function to the summation formula
head(data.frame(s_n = s_n, formula = n*(n+1)/2))

# overlaying our function with the summation formula
plot(n, s_n)
lines(n, n*(n+1)/2)

#Key points
#Poll aggregators combine the results of many polls to simulate polls with a large sample size and therefore generate more precise estimates than individual polls.
#Polls can be simulated with a Monte Carlo simulation and used to construct an estimate of the spread and confidence intervals.
#The actual data science exercise of forecasting elections involves more complex statistical modeling, but these underlying ideas still apply.
#Code: Simulating polls
#Note that to compute the exact 95% confidence interval, we would use qnorm(.975)*SE_hat instead of 2*SE_hat.

d <- 0.039
Ns <- c(1298, 533, 1342, 897, 774, 254, 812, 324, 1291, 1056, 2172, 516)
p <- (d+1)/2

# calculate confidence intervals of the spread
confidence_intervals <- sapply(Ns, function(N){
  X <- sample(c(0,1), size=N, replace=TRUE, prob = c(1-p, p))
  X_hat <- mean(X)
  SE_hat <- sqrt(X_hat*(1-X_hat)/N)
  2*c(X_hat, X_hat - 2*SE_hat, X_hat + 2*SE_hat) - 1
})

# generate a data frame storing results
polls <- data.frame(poll = 1:ncol(confidence_intervals),
                    t(confidence_intervals), sample_size = Ns)
names(polls) <- c("poll", "estimate", "low", "high", "sample_size")
polls
#Code: Calculating the spread of combined polls
#Note that to compute the exact 95% confidence interval, we would use qnorm(.975) instead of 1.96.

d_hat <- polls %>%
  summarize(avg = sum(estimate*sample_size) / sum(sample_size)) %>%
  .$avg

p_hat <- (1+d_hat)/2
moe <- 2*1.96*sqrt(p_hat*(1-p_hat)/sum(polls$sample_size))   
round(d_hat*100,1)
round(moe*100, 1)