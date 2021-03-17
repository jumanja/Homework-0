library(dslabs)
data(heights)

x <- ifelse(heights$sex == "Female", 1, 2)
sum(x)

y <- ifelse(heights$height > 72, heights$height, 0)
mean(y)

inches_to_ft <- function(x){
  f <- x / 12
  f
}
inches_to_ft(144)

cincopies <- ifelse(inches_to_ft(heights$height) < 5, 1, 0)
sum(cincopies)
