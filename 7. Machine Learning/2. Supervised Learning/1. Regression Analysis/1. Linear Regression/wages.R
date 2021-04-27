library(tidyverse)
library(reshape2)
setwd('C:/Users/600037209/Documents/Classes/Data')

#Importing data
wgdata = read.csv('wages.csv') 
View(wgdata)

names(wgdata)

cor(wgdata$age, wgdata$earn)

#Applying linear model
Earnings1 = lm(earn ~ height, data= wgdata)
summary(Earnings1)
predict(Earnings1)
resid(Earnings1)
coef(Earnings1)

ggplot(wgdata, aes(x=height, y=earn)) + geom_point() + 
geom_smooth(method= lm)    
