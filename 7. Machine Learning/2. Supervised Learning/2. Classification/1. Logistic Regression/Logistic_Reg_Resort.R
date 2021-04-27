library(corrplot)
library(ggplot2)
library(dplyr)
library(reshape2)
setwd('C:/Eminent')
vsdata = read.csv('Resort_Visit.csv')
View(vsdata)

names(vsdata)
str(vsdata)
names(vsdata) = c('visit','income','attitude','imp','size','age')
vsdata$visit = factor(vsdata$visit)

visit   = vsdata$visit
income  = vsdata$income
attitude= vsdata$attitude
imp     = vsdata$imp
size    = vsdata$size
age     = vsdata$age


str(visit)
# Convert the respose variable to discrete
visit = factor(visit)
str(visit)


ggplot(vsdata,aes(x=income, y=visit, color=visit)) + geom_point()
ggplot(vsdata,aes(x=age, y=visit, color=visit)) + geom_point()
ggplot(vsdata,aes(x=attitude, y=visit, color=visit)) + geom_point()
ggplot(vsdata,aes(x=imp, y=visit, color=visit)) + geom_point()
ggplot(vsdata,aes(x=size, y=visit, color=visit)) + geom_point()

summary(income)
summary(age)
vsdata$income_segment = cut(income, seq(20,80, by = 20) )

vsdata$age_segment = cut(age, seq(30,75, by = 15) )

table(vsdata$age_segment, vsdata$visit)

View(vsdata)
plot_table = function(a,b) {
    as.data.frame(table(a,b)) %>% 
        ggplot(aes(x = a, y= Freq, fill= b))+
        geom_bar(stat = 'identity')
}

plot_table(vsdata$income_segment, vsdata$visit)
plot_table(vsdata$age_segment, vsdata$visit)
# cgecking the correltion - Xs should not be highly correlated
# Make sure Visit is numeric not factor
vsdata$visit = as.numeric(vsdata$visit)

vsdata$age_segment = NULL
vsdata$income_segment = NULL
cor(vsdata)
M = cor(vsdata)
head(round(M,2))

corrplot(M, method = 'circle')


# Checking relation between Xs and Y
aggregate(income ~visit, FUN = mean)
aggregate(attitude ~visit, FUN = mean)
aggregate(imp ~visit, FUN = mean)
aggregate(size ~visit, FUN = mean)
aggregate(age ~ visit, FUN = mean)


aggregate(income ~visit, FUN = mean) %>% 
    ggplot(aes(x = visit, y = income, fill=visit)) +
    geom_bar(stat="identity") 


rb1 = aggregate(income ~visit, FUN = mean)
rb1$input = 'income'
names(rb1) = c('visit','avg','input')

rb2 = aggregate(attitude ~visit, FUN = mean)
rb2$input = 'attitude'
names(rb2) = c('visit','avg','input')

rb3 = aggregate(imp ~visit, FUN = mean)
rb3$input = 'imp'
names(rb3) = c('visit','avg','input')

rb4 = aggregate(size ~visit, FUN = mean)
rb4$input = 'size'
names(rb4) = c('visit','avg','input')

rb5 = aggregate(age ~ visit, FUN = mean)
rb5$input = 'age'
names(rb5) = c('visit','avg','input')

 
myplotdf = rbind(rb1,rb2,rb3,rb4,rb5)
View(myplotdf)

myplotdf2 = myplotdf[ , c('visit','input','avg')]
View(myplotdf2)

#Higher the difference in means, stronger will be the relation to response variable

#Table display
dcast(myplotdf2, visit ~ input, var.value='avg')

# Graphical display 
ggplot(myplotdf, aes(x = visit, y = avg, fill=visit)) +
    geom_bar(stat="identity") +
    facet_wrap(~input, ncol=5, scales='free') +
    scale_fill_brewer(palette = "Reds")

# to list the avilable palettes   
#RColorBrewer::display.brewer.all()

# checking the diff
boxplot(income ~ visit)
boxplot(income ~ visit)
boxplot(attitude ~ visit)
boxplot(imp ~ visit)
boxplot(size ~ visit)
boxplot(age ~ visit)


# Build the model

model = glm(visit ~ income + attitude + imp  + size + age, 
            family = binomial(logit))

summary(model)


anova(model,test = 'Chisq')

# check for  p <0.05 and redo the model
model = glm(visit ~ income +  size, family = binomial(logit))
summary(model)
coef(model)
 
# cdplots
#   Describing how the conditional distribution of a categorical variable y 
#   changes over a numerical variable x
cdplot(visit ~ income)
cdplot(visit ~ size)


# Fitted values
pred = predict(model,type = 'response')
predclass = ifelse(pred >0.5,"1","0")

# Model evaluation
# classification matrix or confusion matrix

cmtable = table(visit, predclass)
cmtable 

result  = vsdata$visit
result = as.data.frame(result)
names(result) = c('Atual')

View(result)

result$Prob = predict(model, type = 'response')
result$predclass = ifelse(predict(model, type ='response')>0.5,"1","2")


round(prop.table(cmtable),2)*100

# Accuracy  - sum Left to Right diagonal
# Error     - sum Right to Left diagonal


library(caret)
confusionMatrix(visit, predclass)

class(visit)
class(predclass)
predclass = as.factor(predclass)
confusionMatrix(visit, predclass)

summary(visit)
