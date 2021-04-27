library(caret)
library(randomForest)

data("mtcars")

View(mtcars)

str(mtcars)
unique(mtcars$cyl)
mtcars$cyl = factor(mtcars$cyl, 
                    labels = c('Four', 'Six','Eight') )
str(mtcars$cyl)

round(summary(mtcars$cyl)*100/nrow(mtcars),2)

library(caret)
set.seed(123)
idx = createDataPartition(mtcars$cyl, p=.7, list = F)

train = mtcars[idx,]
test  = mtcars[-idx,]

dim(mtcars)
dim(train)
dim(test)

round(summary(train$cyl)*100/nrow(train),2)

model = randomForest(cyl ~ hp + wt + disp + qsec,
                     data = train, do.trace=T)


test$pred = predict(model, test)

confusionMatrix(test$pred, test$cyl)

see_by_cyl = function(n_cyl) {
    return( test[test$cyl == n_cyl, c('cyl','hp','disp')] )
}

summary(model)

getTree(model, labelVar = T)
getTree(model,499, labelVar = T)
see_by_cyl('Four')
see_by_cyl('Six')
see_by_cyl('Eight')

dim(test)
results = predict(model, test, predict.all = T)
results

class(results)
attributes(results)
lapply(results, class)

dim(results$individual)
length(results$aggregate)

test[3,]
results$aggregate[3]
results$individual[3,]

summary(as.factor(results$individual[3,]))

summary(as.factor(results$individual[3,])) * 100/ dim(results$individual)[2]

model$forest$ntree

getTree(model, 6, labelVar = T)

model$importance
