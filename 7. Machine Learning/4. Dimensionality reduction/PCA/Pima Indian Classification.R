# Logistic Regression

# Importing the dataset
autodata = read.csv('PimaIndian.csv')
View(autodata)
names(autodata) 

# Encoding the target feature as factor
#autodata$Accept = factor(autodata$Accept, levels = c(0, 1))

# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(autodata$class, SplitRatio = 0.75)
training_set = subset(autodata, split == TRUE)
test_set = subset(autodata, split == FALSE)
dim(training_set)
dim(test_set)
dim(autodata)

# Feature Scaling
# training_set[-3] = scale(training_set[-3])
# test_set[-3] = scale(test_set[-3])


# Fitting Logistic Regression to the Training set
classifier = glm(class ~ . , family = binomial, data = training_set)
View(test_set)
# Predicting the Test set results
prob_pred = predict(classifier, type = 'response', newdata = test_set[-9])
y_pred = ifelse(prob_pred > 0.5, 1, 0)

# Making the Confusion Matrix
cm = table(test_set[, 9], y_pred)

cm
round(prop.table(cm),2) * 100


names(training_set)

x = training_set[ ,1:8]
y = training_set[ ,9]
class(x)

x= as.matrix(x)
y = as.matrix(y)

x_test = test_set[ ,1:8]
x_test = as.matrix(x_test)
y_pred_knn = knn(x,x_test, y, k =7)
table(test_set[, 9], y_pred_knn)

dim(training_set)
dim(test_set)



library(ROCR)
pred = prediction(prob_pred, test_set$class)
as.numeric(performance(pred, "auc")@y.values)


library(ROCR)

# Make predictions on training set
predictTrain = predict(classifier, type="response")

# Prediction function
ROCRpred = prediction(predictTrain, training_set$class)

# Performance function
ROCRperf = performance(ROCRpred, "tpr", "fpr")

# Plot ROC curve
plot(ROCRperf)

# Add colors
plot(ROCRperf, colorize=TRUE)

# Add threshold labels 
plot(ROCRperf, colorize=TRUE, print.cutoffs.at=seq(0,1,by=0.1), text.adj=c(-0.2,1.7))


