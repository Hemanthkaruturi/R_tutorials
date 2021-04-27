# install.packages(c('caret', 'skimr', 'RANN', 'randomForest', 'fastAdaboost', 'gbm', 'xgboost', 'caretEnsemble', 'C50', 'earth'))

# Load the caret package
library(caret)
library(mlbench)
data(package='mlbench')

# Import dataset
orange = read.csv('https://raw.githubusercontent.com/selva86/datasets/master/orange_juice_withmissing.csv')

# Structure of the dataframe
dim(orange)
str(orange)
dim(orange)
View(orange)
 # See top 6 rows and 10 columns
head(orange[, 1:10])

 table(orange$Purchase)*100/1076
# Create the training and test datasets
set.seed(100)

# Step 1: Get row numbers for the training data
trainRowNumbers = createDataPartition(orange$Purchase, p=0.8, list= F)

# Step 2: Create the training  dataset
trainData = orange[trainRowNumbers,]

# Step 3: Create the test dataset
testData = orange[-trainRowNumbers,]

dim(orange)
# 1070*.8
dim(trainData)
dim(testData)

table(orange$Purchase)*100/nrow(orange)
table(trainData$Purchase)*100/nrow(trainData)
 



# Store X and Y for later use.
x = trainData[, 2:18]
y = trainData$Purchase

install.packages('skimr', dependencies = c('Suggests', 'Depends'))
install.packages('tidyselect', dependencies = c('Suggests', 'Depends'))
install.packages('glue', dependencies = c('Suggests', 'Depends'))
library(skimr)
skimmed = skim_to_wide(trainData)
print(skimmed)
skimmed[, c(1:5, 9:11, 13, 15:16)]

summary(orange$WeekofPurchase)

anyNA(trainData)
sum(is.na(trainData))
dim(trainData)

 


# Create the knn imputation model on the training data
preProcess_missingdata_model = preProcess(trainData, method='knnImpute')
preProcess_missingdata_model


dim(trainData)

count_na_row = 0
result_na_row = 0
for (i in 1:nrow(trainData) ) { 
    result_na = is.na(trainData[i,])
     
    if (sum(result_na) > 1) { 
        
        count_na_row = count_na_row + 1
        result_na_row[count_na_row] = i    
        
                } 
    
    
    }

count_na_row
result_na_row
trainData[747,]

# Use the imputation model to predict the values of missing data points
library(RANN)  # required for knnInpute
trainData = predict(preProcess_missingdata_model, newdata = trainData)
anyNA(trainData)
sum(is.na(trainData))


# One-Hot Encoding
# Creating dummy variables is converting a categorical variable to as many binary variables as here are categories.
dummies_model = dummyVars(Purchase ~ ., data=trainData)
dummies_model

# Create the dummy variables using predict. The Y variable (Purchase) will not be present in trainData_mat.
trainData_mat = predict(dummies_model, newdata = trainData)
trainData_mat

# # Convert to dataframe
trainData = data.frame(trainData_mat)

# # See the structure of the new dataset
str(trainData)

### Data Transformations

# ˆ Instance-based methods are more eective if the input attributes have the same scale.
# ˆ Regression methods can work better if the input attributes are standardized.

# 1. range: Normalize values so it ranges between 0 and 1
# 2. center: Subtract Mean
# 3. scale: Divide by standard deviation
# 4. BoxCox: Remove skewness leading to normality. Values must be > 0
# 5. YeoJohnson: Like BoxCox, but works for negative values.
# 6. expoTrans: Exponential transformation, works for negative values.
# 7. pca: Replace with principal components
# 8. ica: Replace with independent components
# 9. spatialSign: Project the data to a unit circle

preProcess_range_model = preProcess(trainData, method='range')
trainData = predict(preProcess_range_model, newdata = trainData)

View(trainData)
# Append the Y variable
trainData$Purchase = y
str(trainData)
apply(trainData[, 1:10], 2, FUN=function(x){c('min'=min(x), 'max'=max(x))})




#visualize the importance of variables using featurePlot()
scales = list(x = list(relation="free"), 
              y = list(relation="free"))


featurePlot(x = trainData[, 1:18], 
            y = trainData$Purchase, 
            plot = "density",
            scales = scales)

featurePlot(x = trainData[, 1:18], 
            y = trainData$Purchase, 
            plot = "box",
            scales = scales)
View(orange[ , c('PriceCH','Purchase')])
class(preProcess_missingdata_model)
boxplot(orange$PriceCH ~ orange$Purchase)
# RFE 
set.seed(100)
options(warn=-1)

subsets = c(1:3)

ctrl =  rfeControl(functions = rfFuncs,
                   method = "repeatedcv",
                   repeats = 5,
                   verbose = FALSE)

lmProfile =   rfe(x=trainData[, 1:18], y=trainData$Purchase,
                  sizes = subsets,
                  rfeControl = ctrl)

lmProfile

# See available algorithms in caret
modelnames = paste(names(getModelInfo()), collapse=',  ')
modelnames


# Set the seed for reproducibility
set.seed(100)

# Train the model using randomForest and predict on the training data itself.
model_knn = train(Purchase ~ ., data=trainData, method='knn')
fitted_knn    = predict(model_knn)
model_knn


plot(model_knn, main="Model Accuracies with KNN")



model_rf = train(Purchase ~ ., data=trainData, method='rf')
fitted_rf    = predict(model_rf)
model_rf


varimp_rf = varImp(model_rf)
plot(varimp_rf, main="Variable Importance with rf")

# Prepare the test dataset and predict

# order of operations on trainData 
# Missing Value imputation -> One-Hot Encoding -> Range Normalization

# on testData
# preProcess_missingdata_model -> dummies_model -> preProcess_range_model


# Step 1: Impute missing values 
testData2 =  predict(preProcess_missingdata_model, testData)  

# Step 2: Create one-hot encodings (dummy variables)
testData3 = predict(dummies_model, testData2)

# Step 3: Transform the features to range between 0 and 1
testData4 = predict(preProcess_range_model, testData3)

# View
head(testData4[, 1:10])

# Predict on testData
predicted_knn = predict(model_knn, testData4)
head(predicted_knn)

# Compute the confusion matrix
confusionMatrix(reference = testData$Purchase, 
                data = predicted_knn, 
                mode='everything', 
                positive='MM')


# Predict on testData
predicted_rf = predict(model_rf, testData4)
head(predicted_rf)

# Compute the confusion matrix
confusionMatrix(reference = testData$Purchase, 
                data = predicted_rf, 
                mode='everything', 
                positive='MM')


# Hyper tuning

# 1. Set the tuneLength
# 2. Define and set the tuneGrid

# Define the training control
fitControl <- trainControl(
    method = 'cv',                   # k-fold cross validation
    number = 5,                      # number of folds
    savePredictions = 'final',       # saves predictions for optimal tuning parameter
    classProbs = T,                  # should class probabilities be returned
    summaryFunction=twoClassSummary  # results summary function
) 


# Step 1: Tune hyper parameters by setting tuneLength
set.seed(100)
model_knn2 = train(Purchase ~ ., 
                   data=trainData, method='knn', 
                   tuneLength = 5, 
                   metric='ROC', 
                   trControl = fitControl)
model_knn2

# Step 2: Predict on testData and Compute the confusion matrix
predicted2 = predict(model_knn2, testData4)
confusionMatrix(reference = testData$Purchase, 
                data = predicted2, 
                mode='everything', positive='MM')


