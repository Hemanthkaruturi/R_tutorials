spdata  = read.csv('Dataset_spine.csv')
dim(spdata)

View(spdata)

str(spdata)

summary(spdata$Class_att)

View(spdata[,13:14])

spdata2 = spdata[ , -14]
dim(spdata2)

spdata2$Class_att  = factor(spdata$Class_att,
                          levels = c('Abnormal','Normal'),
                          labels = c('0','1') )
library(caTools)
set.seed(123)

split = sample.split(spdata2$Class_att, SplitRatio = 0.7)
train_set = subset(spdata2, split==TRUE)
test_set  = subset(spdata2, split== FALSE)

dim(train_set)
dim(test_set)                     

str(train_set)

log.model = glm(Class_att ~ . , data = train_set, family = 'binomial')                      
summary(log.model)

score_train = predict(log.model, type = 'response') 
summary(score_train)

pred_train  = ifelse(score_train > 0.5, '1','0')

str(train_set$Class_att)
str(pred_train)

pred_train = as.factor(pred_train)

library(caret)
confusionMatrix(train_set$Class_att, pred_train)

summary(pred_train)
summary(train_set$Class_att)

class(pred_train)
class(train_set$Class_att)


df_result = data.frame('cutoff' = numeric(), 'miss_class' = numeric(), 'accuracy' = numeric())

# Making the Confusion Matrix
fun_cutoff = function (df_resutl, cutoff) {
    
    
    y_pred_cutoff = ifelse(score_train > cutoff, 1, 0)
    cm_cutoff = table(train_set$Class_att, y_pred_cutoff)
    missclass_cutoff = round((cm_cutoff[1,2]+cm_cutoff[2,1])*100/sum(cm_cutoff), digits = 2)
    accuracy_cutoff  = round((cm_cutoff[1,1]+cm_cutoff[2,2])*100/sum(cm_cutoff), digits = 2)
    row_cutoff = c(cutoff, missclass_cutoff, accuracy_cutoff)
    
    df_result = rbind(df_result, row_cutoff)
    names(df_result) = c('cutoff', 'miss_class','accuracy')
    return(df_result)
    
}

for(i in seq(.3 , .5, .01) ) {
    
    df_result = fun_cutoff(df_result, i)
    
}
df_result

# decided the cutoff of .42

pred_train  = ifelse(score_train > 0.42, '1','0')

 
pred_train = as.factor(pred_train)

library(caret)
confusionMatrix(train_set$Class_att, pred_train)

score_test = predict(log.model, test_set, type = 'response')

pred_test = ifelse(score_test >= .42, '1','0')
pred_test = as.factor(pred_test)

table(test_set$Class_att, pred_test)
confusionMatrix(test_set$Class_att, pred_test)


M = cor(spdata2[-13])
round(M,2)
