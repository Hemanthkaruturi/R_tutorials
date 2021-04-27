data <- matrix(c(1:10, 21:30), nrow = 5, ncol = 4)
data

#apply
apply(data,2,mean)

#lapply
data <- list(x = 1:5, y = 6:10, z = 11:15)
data
lapply(data, FUN=median)
sapply(data, FUN=median)
library(datasets)
tapply(mtcars$wt, mtcars$cyl, mean)
