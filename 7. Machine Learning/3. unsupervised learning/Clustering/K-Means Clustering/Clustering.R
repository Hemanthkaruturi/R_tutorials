
survey = read.csv('CustSurvery.csv')
names(survey) = c("X1" ,"X2"   , "X3"  ,  "X4"  ,  "X5"  ,  "X6" )
View(survey)
class(survey)
survey = as.matrix(survey)


# compute distance
distance = dist(survey, method = "euclidean")
distance


# Generate Clusters
cl_model = hclust(distance, method = "ward.D")

# Plot Dendogram
plot(cl_model)


groups = cutree(cl_model, k = 3)
rect.hclust(cl_model, k = 3, border = "red")

View(survey)
new_df= cbind(survey, groups)
View(new_df)
new_df = as.data.frame(new_df)
new_df %>%  group_by(groups) %>%  summarise( Avg.X1 = mean(X1),
                                             Avg.X2 = mean(X2),
                                             Avg.X3 = mean(X3),
                                             Avg.X4 = mean(X4),
                                             Avg.X5 = mean(X5),
                                             Avg.X6 = mean(X6))

#
# K Means
#
survey = read.csv('CustSurvery.csv')
names(survey) = c("X1" ,"X2"   , "X3"  ,  "X4"  ,  "X5"  ,  "X6" )
View(survey)
# class(survey)
# survey = as.matrix(survey)
 

mynewmodel = kmeans(survey,3) 
mynewmodel
cluster = mynewmodel$cluster 
mynewmodel$betweenss

output = cbind(survey, cluster)
write.csv(output,'CustSurvery_clout.csv')

#aggregate(survey, by = list(cluster), FUN = mean)

result_df = data.frame(k_val=integer(), 
                       between_by_Totss=numeric())


for (i in 2:19) {
 
result_df[i,1] = i        
i_model = kmeans(survey,i) 
result_df[i,2] = round(i_model$betweenss*100/i_model$totss,2)

}
View(result_df)

plot(result_df$k_val, result_df$between_by_Totss, type = "b")
ggplot(result_df, aes(x=k_val, y=between_by_Totss)) + geom_point() + geom_line()
