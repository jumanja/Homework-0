library(HistData)
data(Galton)
x <- Galton$child
mean(x)
median(x)
quantile(x,0.50)
sd(x)
mad(x)
x_with_error <- x
x_with_error[1] <- x_with_error[1]*10
mean(x)
mean(x_with_error)

# mean(x)
# [1] 68.08847
# mean(x_with_error)
# [1] 68.68685

#mean(x_with_error) - mean(x)  
#[1] 0.5983836
