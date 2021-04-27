#Loan Prediction

#importing packages
if(!require(data.table) | !require(mice) | !require(caTools) | !require(kernlab) | !require(class) | !require(e1071)
   | !require(rpart) | !require(randomForest) | !require(xgboost) | !require(gbm) | !require(caret) | !require(DMwR)
   | !require(missForest) | !require(Amelia)){
  install.packages(c('rpart','randomForest', 'xgboost', 'gbm', 'caret','data.table','mice','caTools',
                     'Kernlab','class','e1071','DMwR','Amelia','missForest'))
}


#importing data
#library(data.table)
#train_data <- fread(file.choose(), stringsAsFactors = T, na.strings = c(""," ",NA))

#import data
train_data <- read.csv('Loan_Prediction_data.csv', na.strings = c(""," ",NA), stringsAsFactors = T)

head(train_data)
sapply(train_data, class)

#checking Missing values
sort(sapply(train_data, function(x) { sum(is.na(x)) }), decreasing=TRUE) #Something wrong at this point

#visualising Missing data
#install.packages("VIM")
library(VIM)
mice_plot <- aggr(train_data, col=c('navyblue','yellow'),
                  numbers=TRUE, sortVars=TRUE,
                  labels=names(train_data), cex.axis=.7,
                  gap=3, ylab=c("Missing data","Pattern"))

#Imputing Missing Values for training set
library(mice)
imputed_data <- mice(train_data[,c(9,10,11)], m=5, maxit = 50, method = 'rf', seed = 500)
train_data[,c(9,10,11)] <- complete(imputed_data, 2)

#Encoding Categorical variables into Numeric for training data
train_data$Gender <- factor(train_data$Gender, labels = c(1,2), levels = c('Female','Male'))
train_data$Married <- factor(train_data$Married, labels = c(0,1), levels = c('No','Yes'))
train_data$Education <- factor(train_data$Education, labels = c(1,2), levels = c('Graduate','Not Graduate') )
train_data$Self_Employed <- factor(train_data$Self_Employed, labels = c(1,2), c('Yes','No'))
train_data$Property_Area <- factor(train_data$Property_Area, labels = c(1,2,3), levels = c('Rural','Urban','Semiurban'))
train_data$Loan_Status <- factor(train_data$Loan_Status, labels = c(0,1), levels = c('N','Y') )

#set column level
levels(train_data$Dependents)[levels(train_data$Dependents) ==  "3+"] <- "3"

#Imputing Missing Value for Gender and Married
imputed_data <- mice(train_data[,c(2,3,6)], m=5, maxit = 50, method = 'rf', seed = 500)
train_data[,c(2,3,6)] <- complete(imputed_data, 2)

#Converting categoical to integer for train data
train_data$Gender <- as.integer(train_data$Gender)
train_data$Loan_ID <- as.integer(train_data$Loan_ID)
train_data$Married <- as.integer(train_data$Married)
train_data$Dependents <- as.integer(train_data$Dependents)
train_data$Education <- as.integer(train_data$Education)
train_data$Self_Employed <- as.integer(train_data$Self_Employed)
train_data$Property_Area <- as.integer(train_data$Property_Area)

#feature Scaling
train_data$Loan_ID <- scale(train_data$Loan_ID)
train_data$Gender <- scale(train_data$Gender)
train_data$Married <- scale(train_data$Married)
train_data$Dependents <- scale(train_data$Dependents)
train_data$Education <- scale(train_data$Education)
train_data$Self_Employed <- scale(train_data$Self_Employed)
train_data$ApplicantIncome <- scale(train_data$ApplicantIncome)
train_data$CoapplicantIncome <- scale(train_data$CoapplicantIncome)
train_data$LoanAmount <- scale(train_data$LoanAmount)
train_data$Loan_Amount_Term <- scale(train_data$Loan_Amount_Term)
train_data$Credit_History <- scale(train_data$Credit_History)
train_data$Property_Area <- scale(train_data$Property_Area)

#Outlier Detection
#install.packages("caTools")

library(DMwR)
outlier.scores <- lofactor(train_data[,-13], k=5)
plot(density(outlier.scores))
outliers <- order(outlier.scores, decreasing=T)[1:5] #Taking Top 5 outliers
print(outliers)
#Visualising outliers
n <- nrow(train_data[,-13])
labels <- 1:n
labels[-outliers] <- "."
biplot(prcomp(train_data[,-13]), cex=.8, xlabs=labels)

#Detecting Outliers using interquartile
quantiles <- quantile(train_data$ApplicantIncome, probs = c(.25, .75))
range <- 1.5 * IQR(train_data$ApplicantIncome)
normal_ApplicantIncome <- subset(train_data$ApplicantIncome,
                                 train_data$ApplicantIncome > (quantiles[1] - range) & train_data$ApplicantIncome < (quantiles[2] + range))
