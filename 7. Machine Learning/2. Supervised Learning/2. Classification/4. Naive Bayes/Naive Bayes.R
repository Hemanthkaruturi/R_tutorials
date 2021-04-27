#Read file  
setwd('C:/Eminent')
mydata = read.csv('Iris.csv')
View(mydata)

#Call library e1071
library(e1071)
View(mydata)

#Develop Model
model = naiveBayes(mydata[,1:4], mydata[,5])
model


#Compute Predicted values
pred = predict(model, mydata[,1:4])
pred
 
# Model evaluation (Actual Vs Predicted)
mytable = table( mydata[,5], pred)
mytable

# 
# #Reading test data file
# mytestdata = read.csv('Iris_test.csv')
# View(mytestdata)
# 
# #Predicting output for test data
# predtest = predict(model, mytestdata[,1:4])
# predtest
# 
# #Model evaluation using test data(Actual Vs Predicted)
# mytesttable = table(predtest,mytestdata[,5])
# mytesttable
