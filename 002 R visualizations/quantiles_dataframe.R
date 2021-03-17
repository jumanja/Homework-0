library(dslabs)
data(heights)
male <- heights$height[heights$sex=="Male"]
female <- heights$height[heights$sex=="Female"]
length(male)
length(female)

male_percentiles <- quantile(male, seq(.1, 0.99, 0.20))
female_percentiles <- quantile(female, seq(.1, 0.99, 0.20))
df <- data.frame(female = female_percentiles, male = male_percentiles)
df