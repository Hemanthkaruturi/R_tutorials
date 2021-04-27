library(tidyverse)
library(caret)
library(caTools)
library(MASS)
data("Boston", package = "MASS")
dataset = Boston
?Boston

names(dataset)
# Split the data into training and test set

set.seed(123)
# using split
split = sample.split(dataset$medv, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)


model = lm(medv ~ . , data= training_set)
summary(model)


predictions = predict(model, newdata = test_set)
data.frame(
RMSE  = RMSE(predictions, test_set$medv),
Rsq   = R2(predictions, test_set$medv) )
library(car)
vif(model)    

model = lm(medv ~ . -tax, data= training_set)
summary(model)

predictions = predict(model, newdata = test_set)
data.frame(
    RMSE  = RMSE(predictions, test_set$medv),
    Rsq   = R2(predictions, test_set$medv) )
