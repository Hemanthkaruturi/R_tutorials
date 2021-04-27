library(caret)
modelLookup('knn')


data(mtcars)

model = lm(mpg~ hp, data=mtcars[1:20,])

predicted = predict(model,mtcars[1:20,],type='response')

actual = mtcars[1:20, 'mpg']

sqrt(mean((predicted-actual)^2))

library(ggplot2)
data("diamonds")
# Fit lm model: model
model=lm(price~.,data=diamonds) 
summary(model)

# Predict on full data: p
p=predict(model,diamonds, type='response')

# Compute errors: error
actual = diamonds[,'price']
error=p-actual

# Calculate RMSE
sqrt(mean((error)^2))

