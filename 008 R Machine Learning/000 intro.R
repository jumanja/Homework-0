data(heights)
heights


head(heights)
class(heights)
class(heights$sex)
class(heights$height)
class("Male")
class(75.00000)

dim(heights)
heights$height[777]

heights$sex[777]
heights[777, 1]

max(heights$height)
which.min(heights$height)

mean(heights$height)
median(heights$height)

myTable <- table(heights$sex)
myTable

x <- heights %>% filter(sex=="Male") %>% pull(height)
F <- function(a) mean(x <= a)
1 - F(78)    # probability of male taller than 78 inches