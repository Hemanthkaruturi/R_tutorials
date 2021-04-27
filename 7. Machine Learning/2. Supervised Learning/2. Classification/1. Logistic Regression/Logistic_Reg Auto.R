 
library(ggplot2)
library(sqldf)
library(reshape2)
library(dplyr)

 
getwd()
setwd('C:/Eminent')
autodata = read.csv('Auto Data.csv', header = T)
View(autodata)

ggplot(autodata,aes(x=Age, y=Accept)) + geom_point() 

names(autodata)     
#is.na(autodata$Age)
dim(autodata)     

#Liner model
autolm = lm(Accept ~ Age, data=autodata)

summary(autolm)
coef(autolm)

#Plotting the result
ggplot(autodata,aes(x=Age, y=Accept)) + geom_point() +
    geom_abline(aes(intercept = -1.29601820, slope = 0.03753232))

boxplot(autodata$Accept ~ autodata$Age)
boxplot(autodata$Age    ~ autodata$Accept)

#Logistic regression
autoglm = glm(Accept ~ Age, data=autodata, family = binomial(logit))
summary(autoglm)                 

#
#anova(autoglm, test='Chisq')

Accept = factor(autodata$Accept)

pred = predict(autoglm, type='response')
res = residuals(autoglm, type='deviance')

predclass = ifelse(pred > 0.5, 1, 0)

myresult = cbind(autodata$Accept, pred,  predclass)

mytable = table(autodata$Accept, predclass)
mytable

round(prop.table(mytable),2) *100


#Conditional Density plots (Response Vs Factors)
#    Describing how the conditional distribution of a categorical variable y 
#    changes over a numerical variable x


str(autodata)
autodata$Accept = factor(autodata$Accept)
View(autodata)

agecount = sqldf('SELECT Age, Accept, COUNT(*) AS agetot FROM autodata GROUP BY Age, Accept')
agecount

tidyage = dcast(agecount, Age ~ Accept, value.var = 'agetot')
names(tidyage)

names(tidyage) = c('Age','Decline','Accept')
tidyage$Decline = ifelse(is.na(tidyage$Decline),
                    0,
                    tidyage$Decline)
View(tidyage)

tidyage$Accept = ifelse( is.na(tidyage$Accept),
                         0,
                         tidyage$Accept)

#tidyage$Tot = tidyage$Accept + tidyage$Decline
tidyage =  mutate(tidyage, Tot = Accept + Decline)

tidyage =  mutate(tidyage, Dprop = Decline/Tot)

ggplot(tidyage,aes(x=Age, y=Dprop)) + geom_point() + geom_smooth()

cdplot(Accept ~ autodata$Age)
