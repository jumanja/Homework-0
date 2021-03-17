library(dslabs)
library(dplyr)
data(heights)
options(digits = 3)
str(heights)

a <- mean(heights$height)
ind <- which(heights$height > a & heights$sex == "Female")

str(ind)
length(ind)

min(heights$height)
match(50, heights$height)
heights$sex[1032]

max(heights$height)
x <- 50:82.7
str(x)

sum(!x %in% heights$height)

heights2 <- mutate(heights, ht_cm = height * 2.54)
str(heights2)
heights2$ht_cm[18]

mean(heights2$ht_cm)

females <- filter(heights2, sex == "Female")
mean(females$ht_cm)