# Logistic Regression

# Importing the dataset
autodata = read.csv('Auto Data.csv')
View(autodata)
names(autodata) 

# Encoding the target feature as factor
#autodata$Accept = factor(autodata$Accept, levels = c(0, 1))

# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(autodata$Accept, SplitRatio = 0.75)
training_set = subset(autodata, split == TRUE)
test_set = subset(autodata, split == FALSE)

# Feature Scaling
# training_set[-3] = scale(training_set[-3])
# test_set[-3] = scale(test_set[-3])


# Fitting Logistic Regression to the Training set
classifier = glm(Accept ~ .,
                 family = binomial,
                 data = training_set)

# Predicting the Test set results
prob_pred = predict(classifier, type = 'response', newdata = test_set[-2])
y_pred = ifelse(prob_pred > 0.5, 1, 0)

# Making the Confusion Matrix
cm = table(test_set[, 2], y_pred > 0.5)


