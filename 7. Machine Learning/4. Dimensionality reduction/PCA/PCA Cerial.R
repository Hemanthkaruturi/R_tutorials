setwd('C:/Eminent')

library(readxl)
crldata_sheets = excel_sheets('Cereals.xls')
crldata = read_excel('Cereals.xls', sheet = 2)

View(crldata)
names(crldata)
dim(crldata)

library(ggplot2)
ggplot(crldata, aes(x=calories, y=rating)) + geom_point() + geom_smooth(method='lm')

crldata2 = crldata[, c('calories','rating')]
View(crldata2)

cor(crldata$calories, crldata$rating)
mean_calories = mean(crldata$calories)
mean_rating   = mean(crldata$rating)

var_calories = var(crldata$calories)
var_rating = var(crldata$rating)
var_total  = var_calories + var_rating

var_calories_prc = var_calories*100/var_total
var_rating_prc   = var_rating  *100/var_total

var_calories_prc
var_rating_prc
 
pca_crldata2 = princomp(crldata2)
summary(pca_crldata2)
attributes(pca_crldata2)
pca_crldata2$loadings

  

#Loadings:
#    Comp.1 Comp.2
#calories -0.847 -0.532
#rating    0.532 -0.847


crldata2[1,]
# cal - 70  rating 68.4

Comp.1 = -.847*(70-mean_calories) + .532*(68.4-mean_rating) 
Comp.2 = -.532*(70-mean_calories) - .847*(68.4-mean_rating)

Comp.1
Comp.2

new_data = pca_crldata2$scores
class(new_data)
new_data = as.data.frame(new_data)
head(new_data)
new_data = cbind(new_data, crldata$name)
View(new_data)

names(new_data)
library(dplyr)

new_data %>%  ggplot(aes(Comp.1, Comp.2)) + geom_point()



crldata_num = crldata[, -c(1,2,3)]
dim(crldata_num)
crldata_num = na.omit(crldata_num)
dim(crldata_num)

pca_crldata_all = princomp(crldata_num)
summary(pca_crldata_all)
attributes(pca_crldata_all)
pca_crldata_all$loadings
 

View(crldata_num)
crldata_znum = scale(crldata_num)
View(crldata_znum)

pca_crldata_zall = princomp(crldata_znum)
summary(pca_crldata_zall)
attributes(pca_crldata_zall)


pca_crldata_zall$loadings
pca_crldata_zall$scores %>% head(3)

eigenvalues = pca_crldata_zall$sdev**2
plot(pca_crldata_zall)


 

rotated_data = pca_crldata_zall$scores[,1:2]
head(rotated_data)


eigenvectors = pca_crldata2$rotation[,1:2]

catcol = 'class'
colcolumn  = data[,catcol]
l1 = levels(colcolumn)
colpalatte = c('green','blue')
mycol =colpalatte[as.numeric(colcolumn)]
head(mycol)    


plot(rotated_data[,1],rotated_data[,2],pch=20, col=mycol, xlab="First PC", ylab="Second PC",
     main=paste('Plot of First 2 PC (colour by :',catcol, ")"))

legend(3.6,4, legend =l1, pch=20, col=colpalatte[1:length(l1)])
