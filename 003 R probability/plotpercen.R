set.seed(16)
act_scores <- rnorm(10000,mean=20.9, sd=5.7)

#1a What is the mean of act_scores
avg_act <- mean(act_scores)
avg_act

#1b What is the standard deviation
sd_act <- sd(act_scores)
sd_act

#1c A perfect score is 36 or greater (the maximum reported score is 36).

#In act_scores, how many perfect scores are there out of 10,000 simulated tests?
mean(act_scores>=36)*10000

# 1d In act_scores, what is the probability of an ACT score greater than 30?
1 - pnorm(30,avg_act,sd_act)

#1e In act_scores, what is the probability of an ACT score less than or equal to 10?
  
pnorm(10, avg_act,sd_act)

#2 Set x equal to the sequence of integers 1 to 36. Use dnorm to determine the value of the probability density function over x given a mean of 20.9 and standard deviation of 5.7; save the result as f_x. Plot x against f_x.
#Which of the following plots is correct?
  
x <- 1:36
f_x <- dnorm(x, avg_act, sd_act)
plot(x, f_x)

#3a What is the probability of a Z-score greater than 2 (2 standard deviations above the mean)?
  
# scaling act_scores
z_act_scores <- scale(act_scores)

# probability of z >= 2
mean(z_act_scores>=2)

#3b What ACT score value corresponds to 2 standard deviations above the mean (Z = 2)?
  
avg_act + 2*sd_act

#3c A Z-score of 2 corresponds roughly to the 97.5th percentile.
#Use qnorm() to determine the 97.5th percentile of normally distributed data with the mean and standard deviation observed in act_scores.
#What is the 97.5th percentile of act_scores?
qnorm(0.975, avg_act, sd_act)

#4a What is the minimum integer score such that the probability of that score or lower is at least .95?
qnorm(.95,avg_act,sd_act)

#4b Use qnorm() to determine the expected 95th percentile, the value for which the probability of receiving that score or lower is 0.95, given a mean score of 20.9 and standard deviation of 5.7.
# What is the expected 95th percentile of ACT scores?
qnorm(.95, 20.9, 5.7)

# 4c As discussed in the Data Visualization course, we can use quantile() to determine sample quantiles from the data.
# Make a vector containing the quantiles for p <- seq(0.01, 0.99, 0.01), the 1st through 99th percentiles of the act_scores data. Save these as sample_quantiles.
# In what percentile is a score of 26?
  
p <- seq(0.01, 0.99, 0.01)
sample_quantiles <- quantile(act_scores,p)

# to determine percentile of a score of 26
names(sample_quantiles[max(which(sample_quantiles < 26))])

# which(s...<26) returns a vector with all percentiles for scores 26 or lower
which(sample_quantiles<26)

# doing max(which(s...< 26)) we isolate the percentile for score 26
max(which(sample_quantiles < 26))

# sample quantile(...) returns the tibble
sample_quantiles[max(which(sample_quantiles < 26))]

# in order to know the value __% we need to use names (like getting the column name)
names(sample_quantiles[max(which(sample_quantiles < 26))])

#4d Make a corresponding set of theoretical quantiles using qnorm() over the interval p <- seq(0.01, 0.99, 0.01) with mean 20.9 and standard deviation 5.7. Save these as theoretical_quantiles. Make a QQ-plot graphing sample_quantiles on the y-axis versus theoretical_quantiles on the x-axis.

# recap, sample_quantiles <- quantile(act_scores, p)
# now we calculate theoretical qs

p <- seq(0.01, 0.99, 0.01)
theoretical_quantiles <- qnorm(p, 20.9, 5.7)

# to qqplot
qqplot(theoretical_quantiles, sample_quantiles)

#The CDF distribution for act_scores with the mean and 5% and 95% quantiles

act_cdf <- sapply(1:36, function (x){
  mean(act_scores <= x)
})

x <- 1:36
y <- act_cdf

ggplot() + geom_line(aes(x,y),size=1) + geom_vline(xintercept = sample_quantiles[95], linetype="dotted", color="green", size=1 ) + geom_vline(xintercept = sample_quantiles[5], linetype="dotted", color="red", size=1 ) + geom_vline(xintercept = avg_act, color="black", alpha=0.2 )