library(dplyr)
library(readxl)


setwd('C:/Eminent')
bankdata = read.csv('UniversalBank.csv')

dim(bankdata)
str(bankdata)
View(bankdata)
names(bankdata)

table(bankdata$Personal.Loan)

bankdata$Family = as.factor(bankdata$Family)
bankdata$Personal.Loan = as.factor(bankdata$Personal.Loan)
bankdata$Education = as.factor(bankdata$Education)
bankdata$Securities.Account = as.factor(bankdata$Securities.Account)
bankdata$CD.Account = as.factor(bankdata$CD.Account)
bankdata$Online = as.factor(bankdata$Online)
bankdata$CreditCard = as.factor(bankdata$CreditCard)


str(bankdata)

table(bankdata$Family)


library(Amelia)
AmeliaView()
missmap(bankdata, y.at = 1, y.labels = "", col = c("yellow", "black"), legend = FALSE)

result_na = sapply(bankdata, function(df) {sum(is.na(df) *100)/ length(df)}) 
result_na = round(result_na, digits = 2)
class(result_na)
View(result_na)

result_na_df = as.data.frame(result_na)
View(result_na_df)

result_na_df$column = row.names(result_na_df)
row.names(result_na_df) = NULL

result_na_df = result_na_df[ , c("column", "result_na")]
str(result_na_df)    

result_na_df = result_na_df %>% arrange( desc(result_na_df$result_na) )
View(result_na_df)

#result_na_df = result_na_df[result_na_df$result_na < 5,]
#View(result_na_df)
#bankdata = bankdata[ , result_na_df$column]

# Ommit NAs

bankdata = na.omit(bankdata)


dim(bankdata)
View(bankdata)

library(ggplot2)
ggplot(bankdata, aes(Age)) + geom_histogram(aes(fill = Personal.Loan), color = "black",
                                         binwidth = 1)



library(caTools)
set.seed(123)
split = sample.split(bankdata$Personal.Loan, SplitRatio = 0.7)
train_set = subset(bankdata, split == TRUE)
test_set  = subset(bankdata, split == FALSE)

dim(train_set)
dim(test_set)


log.model =  glm(Personal.Loan ~ ., family = binomial(), train_set)
summary(log.model)

score_train = predict(log.model, train_set, type = "response")
 
pred_train = ifelse(score_train >= .5, '1','0')
table(train_set$income, pred_train)

summary(score_train)

df_result = data.frame('cutoff' = numeric(), 'miss_class' = numeric(), 'accuracy' = numeric())

# Making the Confusion Matrix
fun_cutoff = function (df_resutl, cutoff) {
    
    
    y_pred_cutoff = ifelse(score_train > cutoff, 1, 0)
    cm_cutoff = table(train_set$income, y_pred_cutoff)
    missclass_cutoff = round((cm_cutoff[1,2]+cm_cutoff[2,1])*100/sum(cm_cutoff), digits = 2)
    accuracy_cutoff  = round((cm_cutoff[1,1]+cm_cutoff[2,2])*100/sum(cm_cutoff), digits = 2)
    row_cutoff = c(cutoff, missclass_cutoff, accuracy_cutoff)
    
    df_result = rbind(df_result, row_cutoff)
    names(df_result) = c('cutoff', 'miss_class','accuracy')
    return(df_result)
    
}

for(i in seq(.1 , .9, .1) ) {
    
    df_result = fun_cutoff(df_result, i)
    
}
df_result

score_test = predict(log.model, test_set, type = 'response')

pred_test = ifelse(score_test >= .5, '1','0')
table(test_set$income, pred_test)





set_prob = cbind(test_set, score_test, pred_test)
View(set_prob)

set_prob = arrange(set_prob, desc(score_test) )

str(set_prob)
summary(set_prob)

  
lift =  function(depvar, predcol, groups=10) {
    
    if(is.factor(depvar)) depvar = as.integer(as.character(depvar))
    if(is.factor(predcol)) predcol = as.integer(as.character(predcol))
    helper = data.frame(cbind(depvar, predcol))
    helper[,"bucket"] = ntile(-helper[,"predcol"], groups)
    gaintable = helper %>% group_by(bucket)  %>%
        summarise_at(vars(depvar), funs(total = n(),
                                        totalresp=sum(., na.rm = TRUE))) %>%
        mutate(Cumresp = cumsum(totalresp),
               Gain=Cumresp/sum(totalresp)*100,
               Cumlift=Gain/(bucket*(100/groups)))
    return(gaintable)
}

dt = lift(set_prob$income  , set_prob$pred_test, groups = 10)
dt

plot(dt$bucket, dt$Cumlift, type="l", ylab="Cumulative lift", xlab="Bucket")

install.packages('gains')
library(gains)

set_prob$income = as.numeric(as.character(set_prob$income))
gain = gains(actual = set_prob$income, predicted = set_prob$score_test)
print.gains(gain)





install.packages('ROCR')
library(ROCR)

pred = prediction(set_prob$score_test , set_prob$income)
gain = performance(pred, "tpr", "rpp")

plot(gain, col="orange", lwd=2)


plot(x=c(0, 1), y=c(0, 1), type="l", col="red", lwd=2,
     ylab="True Positive Rate", 
     xlab="Rate of Positive Predictions")
lines(x=c(0, 0.3, 1), y=c(0, 1, 1), col="darkgreen", lwd=2)

gain.x = unlist(slot(gain, 'x.values'))
gain.y = unlist(slot(gain, 'y.values'))

lines(x=gain.x, y=gain.y, col="orange", lwd=2)

summary(test_set$income)





library(ROCR)
pred = prediction(set_prob$score_test, set_prob$income)
as.numeric(performance(pred, "auc")@y.values)


library(ROCR)

# Make predictions on training set
predictTrain = predict(log.model, type="response")

# Prediction function
ROCRpred = prediction(predictTrain, train_set$income)

# Performance function
ROCRperf = performance(ROCRpred, "tpr", "fpr")

# Plot ROC curve
plot(ROCRperf)

# Add colors
plot(ROCRperf, colorize=TRUE)

# Add threshold labels 
plot(ROCRperf, colorize=TRUE, print.cutoffs.at=seq(0,1,by=0.1), text.adj=c(-0.2,1.7))
 

for(i in seq(.491 , .55, .001) ) {
    
    df_result = fun_cutoff(df_result, i)
    
}
df_result

library(caret)
 
confusionMatrix(test_set$income, pred_test)

str(test_set$income)
str(pred_test)
pred_test = as.factor(pred_test)
str(pred_test)

#              Reference
#Prediction    0    1
#           0 9640  743
#           1 1374 2053

# 'Positive' Class : 0    

TP  = 9640    # predicted as income is <=50K and in reality is also <=50K 
TN  = 2053    # predicted as income is  >50K and in reality is also  >50K
FP  = 743     # predicted as income is <=50K but in reality it  is   >50K     
FN  = 1374    # predicted as income is  >50K but in reality it  is  <=50K

Total = TP+TN+FN+FP

nr = (TN+FP)*(TN+FN) + (FN+TP)*(FP+TP)
dr = Total^2
rand.acc = nr/dr

# Accuracy: Overall, how often is the classifier correct?
tot.acc = (TP+TN)/Total

kappa = (tot.acc-rand.acc)/(1-rand.acc)


#Misclassification Rate: Overall, how often is it wrong?
# 1 - tot.acc
miss.class =    (FP+FN)/Total


# True Positive Rate: When it's actually <=50K(pos), 
#                     how often does it predict same (pos)?
sensitivity_model = TP/(TP+FN)

#Specificity: When it's actually >50K (neg), 
#             how often does it predict >50K (neg)?
specificity_model = TN/(TN+FP)    


Pos_pred_rate     = TP/(TP+FP)
Neg_pred_rate     = TN/(TN+FN)

#Prevalence: How often does the <=50K income (pos) condition actually occur in our sample?
prevalance        = (TP+FN) / Total


# Precision: When it predicts <=50K income (pos), how often is it correct?
precision         = TP/(TP+FP) 

# False Positive Rate: When it's actually >50K (neg), 
#                      how often does it predict <=50K? (pos)
FalsePositiveRate = FP/(TN+FP)

# FalsePositiveRate = 1 - Specificity 
# TruePositiveRate  = Sensitivity 



 


# ROC Curve

