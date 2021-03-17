#Key points
#You may encounter other continuous distributions (Student t, chi-squared, exponential, gamma, beta, etc.).
#R provides functions for density (d), quantile (q), probability distribution (p) and random number generation (r) for many of these distributions.
#Each distribution has a matching abbreviation (for example, norm() or t()) that is paired with the related function abbreviations (d, p, q, r) to create appropriate functions.
#For example, use rt() to generate random numbers for a Monte Carlo simulation using the Student t distribution.
#Code: Plotting the normal distribution with dnorm
#Use d to plot the density function of a continuous distribution. Here is the density function for the normal distribution (abbreviation norm()):
  
  x <- seq(-4, 4, length.out = 100)
data.frame(x, f = dnorm(x)) %>%
  ggplot(aes(x,f)) +
  geom_line()