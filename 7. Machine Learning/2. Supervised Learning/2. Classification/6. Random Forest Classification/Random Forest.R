setwd('C:/Eminent')
install.packages('randomForest')
 
library(randomForest)
library(caret)

mydata = read.csv('Mail_Respond.csv')
View(mydata)
dim(mydata)
names(mydata)
str(mydata)
mydata$Outcome = factor(mydata$Outcome)

#summary(mydata)
#mydata$outcome = factor(mydata$Outcome)




mymodel = randomForest( Outcome ~ District + House_Type + Income + Previous_Customer, # Formula
                        data = mydata,          # Use training data
                        ntree = 10 ,             # No.of Trees
                        mtry  = 3,              # Subset of features to consider while splitting the node
                        do.trace   = T          # Print on console while training 
                        )

print(mymodel)

 
mymodel$forest$ntree
getTree(mymodel, 6, labelVar = T)
mymodel$importance
# printcp(mymodel)
# plotcp(mymodel)

pred = predict(mymodel)
confusionMatrix(mydata$Outcome, pred)

 


# Example 2 

mydata = read.csv('bank-data.csv')
View(mydata)
dim(mydata)
names(mydata)
str(mydata)
mydata$ploan = factor(mydata$ploan)
summary(mydata$ploan)

round(prop.table(summary(factor(mydata$ploan))) * 100,2)

set.seed(1)
sample = sample(1:2, nrow(mydata), replace =TRUE, prob = c(0.8, 0.2))
train = mydata[sample == 1,]
test = mydata[sample == 2, ]
dim(train)
dim(train)
dim(mydata)

names(train)

str(train) 
#detach(train)
#attach(train)
 
#detach(train)
mymodel = randomForest(ploan ~ .,
                data = train,
                ntree = 1000,
                mtry  = 5,
                importance = TRUE ,
                do.trace   = TRUE,
                proximity  = TRUE
)                
 
print(mymodel)
mymodel

pred_train = predict(mymodel)
confusionMatrix(train$ploan, pred_train)
 
pred_test = predict(mymodel, newdata=test)
confusionMatrix(test$ploan, pred_test)


varImpPlot(mymodel)

# pred = predict(mymodel, type = 'class')
# mytable = table(ploan, pred)
# mytable

round(prop.table(mytable)*100,2)

prednew = predict(mymodel, newdata = test, type = 'class')
mynewtable = table(test$ploan, prednew)
mynewtable
confusionMatrix(test$ploan, prednew)
round(prop.table(mynewtable)*100,2)



#for Gini Index
install.packages('ineq')
library(ineq)

matmydata = as.matrix(mydata)

ineq(matmydata, type='Gini')
plot(Lc(matmydata), col='blue',lwd=2)

install.packages('randomForestExplainer')
library(randomForestExplainer) 

explain_forest(mymodel, interactions = T, data = train)


data(Boston, package = "MASS")
Boston$chas = as.logical(Boston$chas)
str(Boston)
set.seed(2017)
forest = randomForest(medv ~ ., data = Boston, localImp = TRUE)
explain_forest(forest, interactions = TRUE, data = Boston)

if (!require(devtools)) install.packages("devtools")
devtools::install_github("MI2DataLab/randomForestExplainer")
