x <- Galton$child
error_avg <- function(k){
  x[1] <- k
  mean(x)
  
}
error_avg(1000)
error_avg(-1000)