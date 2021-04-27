setwd('C:/Eminent') 
# install.packages('rattle')
# install.packages('rpart.plot')
# install.packages('RColorBrewer')
library(rattle)
library(RColorBrewer)
library(rpart.plot)

mydata = read.csv('Mail_Respond.csv')
View(mydata)
dim(mydata)
str(mydata)
mydata$Outcome = factor(mydata$Outcome)
summary(mydata)


house = mydata$House_Type
district = mydata$District
income = mydata$Income
prev = mydata$Previous_Customer
outcome = mydata$Outcome

library(rpart)

mymodel = rpart( outcome ~ district + house + income + prev, 
                 method = 'class', 
                 control = rpart.control(minsplit = 2))
#When response is categorical, method = 'class', when response is numeric, methos = 'anova'

print(mymodel)


plot(mymodel)
text(mymodel, pretty = 0)
library(rattle)
library(RColorBrewer)
fancyRpartPlot(mymodel)

printcp(mymodel)
plotcp(mymodel)
pred = predict(mymodel)

predclass = ifelse(pred[,1] > 0.5, '1', '2')
mytable = table(outcome, predclass)


mydata = read.csv('bank-data.csv')
View(mydata)
dim(mydata)
prop.table(summary(factor(mydata$pep)))

set.seed(1)
sample = sample(2, nrow(mydata), replace =TRUE, prob = c(0.8, 0.2))
train = mydata[sample == 1,]
test = mydata[sample == 2, ]
attach(train)
library(rpart)

 detach(train)
mymodel = rpart(pep ~ age + sex+ region + income + married + children + car +
                         save_act + current_act + mortgage, 
                data = train,   
                method = "class", 
                control = rpart.control(minsplit = 40))
mymodel

plot(mymodel)
text(mymodel, pretty = 0)

printcp(mymodel)
plotcp(mymodel)

fancyRpartPlot(mymodel)

mymodel$variable.importance


pred = predict(mymodel, type = 'class')
mytable = table(train$pep, pred)

mytable
round(prop.table(mytable)*100,2)

prednew = predict(mymodel, newdata = test, type = 'class')
mynewtable = table(test$pep, prednew)
mynewtable
round(prop.table(mynewtable)*100,2)

#for Gini Index
install.packages('ineq')
library(ineq)

matmydata = as.matrix(mydata)

ineq(matmydata, type='Gini')

install.packages('DescTools')
library(DescTools)
Gini(matmydata)

plot(Lc(matmydata))

#The complexity parameter (cp) is used to control the size of the decision tree and to select 
#the optimal tree size. If the cost of adding another variable to the decision tree from 
#the current node is above the value of cp, then tree building does not continue. 