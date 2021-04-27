 
# Load and explore the dataset
attach(iris)
str(iris)

View(iris)
names(iris)
# Subset the features to get 2-D dataset
irisData = as.data.frame(iris[  ,c(1,3)])
View(irisData)
     
plot(irisData, pch = 19)

library(ggplot2)
library(dplyr)

iris %>%  ggplot( aes(x=Sepal.Length, y=Petal.Length, color=Species)) +
                      geom_point()
 
# Set color palette for visualization
# install.packages("RColorBrewer")
library(RColorBrewer)
display.brewer.all()
myPal = brewer.pal(n = 8, name = "Dark2")


# -------------------------------------------------------
# Hierarchical Clustering : Minimum Variance
# Prioratizes compact and spherical clusters

hiercFit = hclust(dist(irisData), method="ward.D")
hiercFit
plot(hiercFit, main="Minimum Variance", xlab="", ylab="", sub="", cex =.5)

K = 4

plot(hiercFit, main="Minimum Variance", xlab="", ylab="", sub="", cex =.5)
rect.hclust(hiercFit, k = K)

clust_num = cutree(hiercFit, k = K)

plot(irisData, pch = 8, col = palette(myPal)[as.numeric(clust_num)])
#plot(irisData, pch = 19, col = palette(myPal)[as.numeric(cutree(hiercFit, k = K))])
