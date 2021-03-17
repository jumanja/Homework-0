library(tidyverse)
library(dslabs)
data(heights)
x <- heights %>% filter(sex=="Male") %>% pull(height)

pnorm(70.5, mean(x), sd(x))

#x <- heights$height[heights$sex == "Male"]
#mean(x >= 69 & x <= 72)

# plot distribution of exact heights in data
plot(prop.table(table(x)), xlab = "a = Height in inches", ylab = "Pr(x = a)")

# probabilities in actual data over length 1 ranges containing an integer
mean(x <= 68.5) - mean(x <= 67.5)
mean(x <= 69.5) - mean(x <= 68.5)
mean(x <= 70.5) - mean(x <= 69.5)

# probabilities in normal approximation match well
pnorm(68.5, mean(x), sd(x)) - pnorm(67.5, mean(x), sd(x))
pnorm(69.5, mean(x), sd(x)) - pnorm(68.5, mean(x), sd(x))
pnorm(70.5, mean(x), sd(x)) - pnorm(69.5, mean(x), sd(x))

# probabilities in actual data over other ranges don't match normal approx as well
mean(x <= 70.9) - mean(x <= 70.1)
pnorm(70.9, mean(x), sd(x)) - pnorm(70.1, mean(x), sd(x))



#library(dslabs)
#data(heights)
x <- heights$height[heights$sex=="Male"]
avg <- mean(x)
stdev <- sd(x)
pnorm(72, avg, stdev) - pnorm(69, avg, stdev)

exact <- mean(x > 79 & x <= 81)
approx <- pnorm(81, mean(x), sd(x)) - pnorm(72, mean(x), sd(x))
#how many times is bigger
exact / approx

# use pnorm to calculate the proportion over 7 feet (7*12 inches)
pnorm(84, 69, 3, FALSE)

p <- pnorm(84, 69, 3, FALSE)
round(p * (10 ^9))

2.866516e-07
287

N <- round(pnorm(84, 69, 3, FALSE) * (10 ^9))
287 / N

## Change the solution to previous answer
p <- 1 - pnorm(7*12, 69, 3)
N <- round(p * 10^9)
10/N

p <- 1 - pnorm(6*12 + 8, 69, 3)
N <- round(p * 10^9)
150/N