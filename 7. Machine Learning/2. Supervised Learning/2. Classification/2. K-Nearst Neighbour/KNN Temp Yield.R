install.packages('class')
library(class)

setwd('C:/Eminent')
mydata = read.csv('Mult_Reg_Yield.csv')
View(mydata)
summary(mydata)

x = mydata[ ,1:2]
y = mydata[ ,3]
class(x)

x= as.matrix(x)
y= as.matrix(y)

 
pred  = knn(x, x, y, k = 3)
pred 

myresult = cbind(mydata, pred)
View(myresult)
str(myresult)
myresult$pred = as.numeric(myresult$pred)
myresult$diff = myresult$pred - myresult$Yield
myresult$sqerr = myresult$diff * myresult$diff

sum(myresult$sqerr)
MeanSqError = mean(myresult$sqerr)
RMSE = sqrt(MeanSqError)
RMSE

#RMSE for K= 3
# 62.14215

#RMSE for K= 5
# 61.35733



knn_k = function (n) {
    pred  = knn(x, x, y, k = n)
    pred 
    
    myresult = cbind(mydata, pred)

    myresult$pred = as.numeric(myresult$pred)
    myresult$diff = myresult$pred - myresult$Yield
    myresult$sqerr = myresult$diff * myresult$diff
    
     
    MeanSqError = mean(myresult$sqerr)
    RMSE = sqrt(MeanSqError)
    return(RMSE)
    
}


knn_k(3)
result_df = data.frame(k_val = numeric(), RMSE = numeric() )
 
for(i in 1:16) {

 row_k = c(i , knn_k(i) )      
 result_df = rbind(result_df, row_k)

    
}

View(result_df)





mytestdata = read.csv('Iris_test.csv')
View(mytestdata)
testx = mytestdata[,1:4]
testy = mytestdata[,5]
testx = as.matrix((testx))
#Predicting output for test data
pred_5 = knn(testx, testx, testy, k = 5)
class(pred_5)

mytesttable = table(testy, pred_5)
mytesttable


 
pred_1 = knn(testx, testx, testy, k = 1)
pred_3 = knn(testx, testx, testy, k = 3)
pred_5 = knn(testx, testx, testy, k = 5)
pred_7 = knn(testx, testx, testy, k = 7)
pred_9 = knn(testx, testx, testy, k = 9)


mytable_1 = table(testy, pred_1)
mytable_3 = table(testy, pred_3)
mytable_5 = table(testy, pred_5)
mytable_7 = table(testy, pred_7)
mytable_9 = table(testy, pred_9) 

mytable_1  
mytable_3  
mytable_5  
mytable_7 
mytable_9
  

mydata = read.csv('RidingMowers.csv')
View(mydata)

x = mydata[,1:2]
y = mydata[,3]
x= as.matrix(x)
y = as.matrix(y)

pred_5 = knn(x, x, y, k = 5)
pred_5

mytable_5 = table(y, pred_5)
mytable_5
class(y)
class(pred_5)
y_factor = as.factor(y)
library(caret)
confusionMatrix(y_factor, pred_5)
