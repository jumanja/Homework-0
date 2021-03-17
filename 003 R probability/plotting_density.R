library(tidyverse)
x <- seq(-4, 4, length = 100)
data.frame(x, f = dnorm(x)) %>%
  ggplot(aes(x, f)) +
  geom_line()

# Note that dnorm() gives densities for the standard normal distribution by default. Probabilities for alternative normal distributions with mean mu and standard deviation sigma can be evaluated with:
  
  dnorm(z, mu, sigma)