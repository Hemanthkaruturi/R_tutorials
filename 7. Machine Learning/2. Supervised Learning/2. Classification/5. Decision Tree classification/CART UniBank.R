setwd('C:/Eminent') 
# install.packages('rattle')
# install.packages('rpart.plot')
# install.packages('RColorBrewer')


library(rattle)
library(RColorBrewer)
library(rpart.plot)

loandata = read.csv('UniversalBank.csv')
View(loandata)
dim(loandata)
str(loandata)
names(loandata)
names(loandata)[10] = 'ploan'

loandata = loandata[ , -c(1,5)]
loandata$ploan = as.factor(loandata$ploan)
prop.table(summary(loandata$ploan))

loan_model = rpart(ploan ~ ., 
                   data = loandata,   
                   method = "class", 
                   control = rpart.control(minsplit = 1))

print(loan_model)

plot(loan_model)
text(loan_model, pretty = 0)

rpart.plot(loan_model)



set.seed(1)

sample = sample(1:2, nrow(loandata), replace =TRUE, prob = c(0.8, 0.2))
train = loandata[sample == 1,]
test  = loandata[sample == 2, ]

library(rpart)

loan_model = rpart(ploan ~ ., 
                data = train,   
                method = "class", 
                control = rpart.control(minsplit = 1, 
                                        cp = 0.00000001))
loan_model
rpart.plot(loan_model)


printcp(loan_model)
plotcp(loan_model)

fancyRpartPlot(loan_model)

#loan_model$variable.importance


pred = predict(loan_model, type = 'class')
cm_train = table(train$ploan, pred)

cm_train
round(prop.table(cm_train)*100,2)

pred_test = predict(loan_model, newdata = test, type = 'class')
cm_test = table(test$ploan, pred_test)
cm_test
round(prop.table(cm_test)*100,2)


library(caret)
str(pred_test)
str(test$ploan)
confusionMatrix(data = pred_test,
                reference = test$ploan)

#for Gini Index
install.packages('ineq')
library(ineq)

mat_loandata = as.matrix(loandata)

ineq(mat_loandata, type='Gini')

install.packages('DescTools')

library(DescTools)
Gini(mat_loandata)

plot(Lc(mat_loandata))

#The complexity parameter (cp) is used to control the size of the decision tree and to select 
#the optimal tree size. If the cost of adding another variable to the decision tree from 
#the current node is above the value of cp, then tree building does not continue. 

cv.ct = rpart(ploan ~ ., data = train , method = "class",
               cp = 0.00001, 
               minsplit = 5, 
               xval = 10)
printcp(cv.ct)
plotcp(cv.ct)
