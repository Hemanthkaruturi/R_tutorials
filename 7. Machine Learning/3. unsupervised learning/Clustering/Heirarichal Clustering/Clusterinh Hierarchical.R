# Hierarchical Clustering

# Importing the dataset
dataset = read.csv('Mall_Customers.csv')
View(dataset)
dataset = dataset[4:5]
View(dataset)
names(dataset)
names(dataset) = c('Income','Score')
View(dataset)

# Using the dendrogram to find the optimal number of clusters
dendrogram = hclust(d = dist(dataset, method = 'euclidean'), method = 'ward.D')
plot(dendrogram,
     main = paste('Dendrogram'),
     xlab = 'Customers',
     ylab = 'Euclidean distances')

# Fitting Hierarchical Clustering to the dataset
hc = hclust(d = dist(dataset, method = 'euclidean'), method = 'ward.D')
y_hc = cutree(hc, 5)

# Visualising the clusters

library(cluster)
clusplot(dataset,
         y_hc,
         lines = 0,
         shade = TRUE,
         color = TRUE,
         labels= 2,
         plotchar = FALSE,
         span = TRUE,
         main = paste('Clusters of customers'),
         xlab = 'Annual Income',
         ylab = 'Spending Score')

out_data = cbind(dataset, y_hc)
View(out_data)
library(rgl)
plot3d(dataset$Income,dataset$Score,y_hc, col="red", size=5)
open3d()
