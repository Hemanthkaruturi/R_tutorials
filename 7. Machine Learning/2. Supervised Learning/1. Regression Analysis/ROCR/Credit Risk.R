getwd()
setwd('C:/Eminent')
install.packages('gmodels')
library(gmodels)


 
df_loan =  read.csv('Credit Risk.csv')  
df_loan = df_loan[,-1]
dim(df_loan) 
View(df_loan)
str(df_loan)

CrossTable(df_loan$grade, df_loan$loan_status,
           prop.c = F, prop.chisq = F, prop.t = F,  prop.r = T)

CrossTable(df_loan$loan_status)

# 1. Univariate Anaysis

# 1.1 Analysis of annual_income

#hist(df_loan$int_rate, main='Histogram of Int.rate', xlab = 'Int.rate')

hist_income = hist(df_loan$annual_inc, breaks = 100,main='Histogram of Income', xlab = 'Income')
hist_income$breaks

n_breaks  = sqrt(nrow(df_loan))
hist_income_n = hist(df_loan$annual_inc, breaks = n_breaks,main='Histogram of Income', xlab = 'Income')
hist_income_n

plot(df_loan$annual_inc, ylab = 'Annual Income')
boxplot(df_loan$annual_inc)

# 1.1.1 Outiiers of annual_income

# 1.1.1.1 - Cutoff using Domain knowledge 
ix_outlier_exp = which(df_loan$annual_inc > 3000000)
df_loan_exp    = df_loan[-ix_outlier_exp,]

n_breaks  = sqrt(nrow(df_loan_exp))
hist_income_n_exp = hist(df_loan_exp$annual_inc, breaks = n_breaks,main='Histogram of Income', xlab = 'Income')

plot(df_loan_exp$annual_inc, ylab = 'Income')
 # 1.1.1.2 - Cutoff using IQR
IQR_income = IQR(df_loan$annual_inc)
quantile(df_loan$annual_inc)
outlier_cutoff = quantile(df_loan$annual_inc, probs = 0.75) + 1.5*IQR_income

ix_outlier_IQR  = which(df_loan$annual_inc > outlier_cutoff)
df_loan_IQR     = df_loan[-ix_outlier_IQR,]

n_breaks  = sqrt(nrow(df_loan_IQR))
hist_income_n_IQR = hist(df_loan_IQR$annual_inc, breaks = n_breaks,main='Histogram of Income', xlab = 'Income')

# 1.1.2 - Bivatiate analysis of annual_income

plot(df_loan_IQR$emp_length, df_loan_IQR$annual_inc)

# Excercise 

# 1.1 Analysis of age

# 1.1.1 Outiiers of age

# 1.1.1.1 - Cutoff using Domain knowledge

# 1.1.1.2 - Cutoff using IQR

# 1.1.2 - Bivatiate analysis of age



# Excercise 

# 1.1 Analysis of age
hist(df_loan$age, main = 'Histogram of Age', xlab = 'Age')
plot(df_loan$age, ylab = 'Frequncy')

# 1.1.1 Outliers of age

# 1.1.1.1 - Cutoff using Domain knowledge

ix_outlier_exp_age = which(df_loan$age > 80)
df_loan[ix_outlier_exp_age,]
df_loan_exp_age  = df_loan[-ix_outlier_exp_age,]

n_breaks = sqrt(nrow(df_loan_exp_age))
hist(df_loan_exp_age$age, main = 'Histogram of Age', xlab = 'Age', breaks = n_breaks)
plot(df_loan_exp_age$age, ylab = 'Frequncy')

# 1.1.1.2 - Cutoff using IQR
IQR_age = IQR(df_loan$age)
outlier_cutoff_age = quantile(df_loan$age, probs = 0.75) + 1.5*IQR_age

ix_outlier_IQR_age = which(df_loan$age > outlier_cutoff_age)
 
df_loan_IQR_age  = df_loan[-ix_outlier_IQR_age,]

n_breaks = sqrt(nrow(df_loan_IQR_age))
hist(df_loan_IQR_age$age, main = 'Histogram of Age', xlab = 'Age', breaks = n_breaks)
plot(df_loan_IQR_age$age, ylab = 'Frequncy')


# 1.1.2 - Bivatiate analysis of age

plot(df_loan$age, df_loan$loan_amnt)
plot(df_loan_IQR_age$age, df_loan_IQR_age$loan_amnt)
plot(df_loan_exp_age$age, df_loan_exp_age$loan_amnt)

# 2 Missing Data

summary(df_loan$emp_length)

hist(df_loan_IQR$age, main = 'Histogram of Age', xlab = 'Age', breaks = n_breaks)
plot(df_loan_IQR$age, ylab = 'Frequncy')

summary(df_loan_IQR)

df_loan_IQR = na.omit(df_loan_IQR)


library(caTools)
set.seed(100)
spl = sample.split(df_loan_IQR$loan_status, 0.7)
train = subset(df_loan_IQR, spl == TRUE)
test = subset(df_loan_IQR, spl == FALSE)

dim(train)
dim(test)

modLog = glm(loan_status ~ .-age,data=train, family="binomial")
summary(modLog)

# Prediction 
test$predicted.risk = predict(modLog, newdata=test, type="response")
summary(test$predicted.risk)


test$pred_class = ifelse(test$predicted.risk >= 0.23,1,0)
# Accuracy
#table(test$loan_status, as.numeric(test$predicted.risk >= 0.5))
table(test$loan_status, test$pred_class)

# baseline
table(test$loan_status)
6491/(6491+808)


 
df_result = data.frame('cutoff' = numeric(), 'miss_class' = numeric(), 'accuracy' = numeric())

# Making the Confusion Matrix
fun_cutoff = function (df_resutl, cutoff) {
    
    
    y_pred_cutoff = ifelse(test$predicted.risk > cutoff, 1, 0)
    cm_cutoff = table(test$loan_status, y_pred_cutoff)
    missclass_cutoff = (cm_cutoff[1,2]+cm_cutoff[2,1])/sum(cm_cutoff)
    accuracy_cutoff  = (cm_cutoff[1,1]+cm_cutoff[2,2])/sum(cm_cutoff)
    row_cutoff = c(cutoff, missclass_cutoff, accuracy_cutoff)
    
    df_result = rbind(df_result, row_cutoff)
    names(df_result) = c('cutoff', 'miss_class','accuracy')
    return(df_result)
    
}

for(i in seq(.1 , .43, .01) ) {
    
    df_result = fun_cutoff(df_result, i)
    
}
df_result


library(ROCR)
pred = prediction(test$predicted.risk, test$loan_status)
as.numeric(performance(pred, "auc")@y.values)


library(ROCR)

# Make predictions on training set
predictTrain = predict(modLog, type="response")

# Prediction function
ROCRpred = prediction(predictTrain, train$loan_status)

# Performance function
ROCRperf = performance(ROCRpred, "tpr", "fpr")

# Plot ROC curve
plot(ROCRperf)

# Add colors
plot(ROCRperf, colorize=TRUE)

# Add threshold labels 
plot(ROCRperf, colorize=TRUE, print.cutoffs.at=seq(0,1,by=0.1), text.adj=c(-0.2,1.7))

t1 = table(test$loan_status, as.numeric(test$predicted.risk >= 0.25))
t1
