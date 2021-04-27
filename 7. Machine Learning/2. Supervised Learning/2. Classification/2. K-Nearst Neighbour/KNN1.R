# install.packages('class')
library(class)

mydata = read.csv('Iris.csv')
View(mydata)
summary(mydata)

x = mydata[ ,1:4]
y = mydata[ ,5]
class(x)

x= as.matrix(x)
y = as.matrix(y)

pred = knn(x, x, y, k = 5)
pred

#confusion matrix
mytable = table(y, pred)
mytable


mytestdata = read.csv('Iris_test.csv')
View(mytestdata)
testx = mytestdata[,1:4]
testy = mytestdata[,5]
testx = as.matrix((testx))
#Predicting output for test data
pred_5 = knn(x, testx, y, k = 5)

mytesttable = table(testy, pred_5)
mytesttable

 
pred_2 = knn(x, testx, y, k = 2)
pred_3 = knn(x, testx, y, k = 3)
pred_4 = knn(x, testx, y, k = 4)
pred_6 = knn(x, testx, y, k = 6)
pred_7 = knn(x, testx, y, k = 7)
pred_8 = knn(x, testx, y, k = 8)

 
mytable_2 = table(testy, pred_2)
mytable_3 = table(testy, pred_3)
mytable_4 = table(testy, pred_4)
mytable_6 = table(testy, pred_6)
mytable_7 = table(testy, pred_7)
mytable_8 = table(testy, pred_8)

   
mytable_2  
mytable_3  
mytable_4  
mytable_5 
mytable_6  
mytable_7 
mytable_8  

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



