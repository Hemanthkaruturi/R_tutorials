sldata = read.csv('Soldier.csv')
View(sldata)

names(sldata)
sldata = sldata[,c(2,3,6,7)]

colMeans(sldata)
apply(sldata,2,sd)

sldata = scale(sldata)
View(sldata)
# H.clust

clust_h = hclust(dist(sldata), method='ward.D')
groups = cutree(clust_h,k=3)
groups

sld_clus = cbind(sldata, groups)
View(sld_clus)
library(dplyr)
sld_clus %>% group_by(groups) %>% summarise( Mean_Atk = mean(Attack), 
                                             Mean_Def = mean(Defense),
                                             Mean_spd = mean(Speed),
                                             Mean_End = mean(Endurance))



# KMeans

clust_k = kmeans(sldata,3)
clust_k
cluster = clust_k$cluster
cluster

table(groups, cluster)


new_df = cbind(sldata,groups,cluster)
View(new_df)

library(dplyr)
 
as.data.frame(new_df) %>% filter(groups == 1)


?kmeans


