setwd('C:/Eminent') 
# install.packages('rattle')
# install.packages('rpart.plot')
# install.packages('RColorBrewer')
# install.packages('DescTools')
# install.packages('ineq')


library(rattle)
library(RColorBrewer)
library(rpart.plot)
library(ggplot2)
library(caret)
library(rpart)



loandata = read.csv('bank-data.csv')
View(loandata)
dim(loandata)
str(loandata$ploan)
loandata$ploan = as.factor(loandata$ploan)
 



set.seed(10)
sample = sample(1:2, nrow(loandata), replace =TRUE, prob = c(0.6, 0.4))
prop.table(summary(as.factor(sample)))
           
train = loandata[sample == 1, ]
test  = loandata[sample == 2, ]

loan_model = rpart(ploan ~ ., 
                data = train,   
                method = "class", 
                control = rpart.control(maxdepth = 2))

pred_train = predict(loan_model, type = 'class')
pred_test  = predict(loan_model, newdata = test, type = 'class')

cm_train = confusionMatrix(data = pred_train,
                reference = train$ploan)
cm_test  = confusionMatrix(data = pred_test,
                reference = test$ploan)

 
cm_train_df = as.data.frame(as.matrix(cm_train, what = 'overall'))
cm_test_df  = as.data.frame(as.matrix(cm_test, what = 'overall'))

Error_train = 1- cm_train_df['Accuracy',]
Error_test  = 1- cm_test_df['Accuracy',]


Error_train
Error_test

df_result = data.frame( 'maxdepth' = numeric(), 
                        'Er_train' = numeric(),
                        'Er_test'  = numeric()
)

fun_Error = function(df_result, num_maxdepth) {
    loan_model = rpart(ploan ~ ., 
                       data = train,   
                       method = "class", 
                       control = rpart.control(maxdepth = num_maxdepth))
    
    pred_train = predict(loan_model, type = 'class')
    pred_test  = predict(loan_model, newdata = test, type = 'class')
    
    cm_train = confusionMatrix(data = pred_train,
                               reference = train$ploan)
    cm_test  = confusionMatrix(data = pred_test,
                               reference = test$ploan)
    
    
    cm_train_df = as.data.frame(as.matrix(cm_train, what = 'overall'))
    cm_test_df  = as.data.frame(as.matrix(cm_test, what = 'overall'))
    
    Error_train = 1- cm_train_df['Accuracy',]
    Error_test  = 1- cm_test_df['Accuracy',]
    
    

    result_rec = c(num_maxdepth,Error_train,Error_test)    
    df_result = rbind(df_result, result_rec)
    names(df_result) = c('maxdepth', 'Er_train','Er_test')
    return(df_result)
}

for(i in seq(1 , 10, 1) ) {
    
    df_result = fun_Error(df_result, i)
    
}
df_result 
#for Gini Index

library(ineq)

mat_loandata = as.matrix(loandata)

ineq(mat_loandata, type='Gini')



library(DescTools)
Gini(mat_loandata)

plot(Lc(mat_loandata))

#The complexity parameter (cp) is used to control the size of the decision tree and to select 
#the optimal tree size. If the cost of adding another variable to the decision tree from 
#the current node is above the value of cp, then tree building does not continue. 