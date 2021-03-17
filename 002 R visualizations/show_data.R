
library(dslabs)
data(heights)
x <- heights$height
length(unique(x))

# load the dataset
library(dslabs)
data(heights)

# make a table of category proportions
# so 22% female and 77% male
prop.table(table(heights$sex))

#a <- seq(min(my_data), max(my_data), length = 100)    # define range of values spanning the dataset
#cdf_function <- function(x) {    # computes prob. for a single value
#  mean(my_data <= x)
#}
#cdf_values <- sapply(a, cdf_function)
#plot(a, cdf_values)