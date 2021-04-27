#Develop a model to predict plant class using the data given in Iris.csv using random forest method.
#Validate the model with Iris_test.csv data?
install.packages('randomForest')
install.packages('randomForestExplainer')

library(randomForest)

mydata = read.csv('Iris.csv')
names(mydata)

mymodel = randomForest(Class ~ sepal.length + sepal.width + petal.length + petal.width, data = mydata)
mymodel


newdata = read.csv('Iris_test.csv')
names(newdata)

pred = predict(mymodel, newdata = newdata)
mytable = table(newdata$Class, pred)
mytable


 
