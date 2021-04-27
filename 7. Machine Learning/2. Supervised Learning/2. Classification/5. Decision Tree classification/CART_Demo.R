setwd('C:/Eminent')
owndata = read.csv('RidingMowers.csv')
View(owndata)
str(owndata)

library(ggplot2)

ggplot(owndata, aes(x=Income, y=Lot_Size,color=Ownership)) +
     geom_point()


library(dplyr)
library(sqldf)
tot_prop = sqldf('select Ownership, count(*) as count from owndata group by Ownership')
class(tot_prop)

tot_prop

tot_prop$prop = tot_prop$count/sum(tot_prop$count)
tot_prop$prop_sq = tot_prop$prop ^ 2

gini_total = 1 - sum(tot_prop$prop_sq)
gini_total

ggplot(owndata, aes(x=Income, y=Lot_Size,color=Ownership)) +
    geom_point() + geom_hline(yintercept = 19)

owndata_1a = owndata[owndata$Lot_Size <= 19 , ]
dim(owndata_1a)

owndata_1b = owndata[owndata$Lot_Size > 19 , ]
dim(owndata_1b)

prop_1a = sqldf('select Ownership, count(*) as count from owndata_1a group by Ownership')
prop_1a
prop_1a$prop = prop_1a$count/sum(prop_1a$count)
prop_1a$prop_sq = prop_1a$prop ^ 2

gini_1a = 1 - sum(prop_1a$prop_sq)
gini_1a

prop_1b = sqldf('select Ownership, count(*) as count from owndata_1b group by Ownership')
prop_1b
prop_1b$prop = prop_1b$count/sum(prop_1b$count)
prop_1b$prop_sq = prop_1b$prop ^ 2

gini_1b = 1 - sum(prop_1b$prop_sq)
gini_1b

(12/24)*gini_1a + (12/24)*gini_1b


ggplot(owndata, aes(x=Income, y=Lot_Size,color=Ownership)) +
    geom_point() + geom_hline(yintercept = 19) + 
    geom_segment(aes(x = 84.5, y = 14, xend = 84.5, yend = 19) ) 
                    

library(rattle)
library(RColorBrewer)
library(rpart.plot)

library(rpart)

mymodel = rpart(Ownership ~ Lot_Size + Income, 
                data = owndata,
                method = 'class',
                control = rpart.control(minsplit = 1)
               )
#  control = rpart.control(minsplit = 19)

#When response is categorical, method = 'class'  
#when response is numeric, methos = 'anova'

print(mymodel)
plot(mymodel)
text(mymodel, pretty = 0)


fancyRpartPlot(mymodel)

printcp(mymodel)
plotcp(mymodel)
pred = predict(mymodel)

 
