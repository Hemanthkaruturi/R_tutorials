getwd()
setwd("C:/Eminent")
library(dplyr)
library(ggplot2)

# Logistic Regression

# Importing the dataset
dataset = read.csv('Social_Network_Ads.csv')
View(dataset)
dataset = dataset[3:5]
str(dataset)

# Encoding the target feature as factor
dataset$Purchased = factor(dataset$Purchased, levels = c(0, 1))

# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Purchased, SplitRatio = 0.75)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)
dim(training_set)
dim(test_set)
names(test_set)

# Feature Scaling
View(training_set)
str(training_set)

training_set[-3] = scale(training_set[-3] )
test_set[-3] = scale(test_set[-3])

# Fitting Logistic Regression to the Training set
classifier = glm(formula = Purchased ~ .,
                 family = binomial,
                 data = training_set)

summary(classifier)
# Predicting the Test set results
prob_pred = predict(classifier, type = 'response', newdata = test_set[-3])


y_pred_.5 = ifelse(prob_pred > 0.5, 1, 0)
y_pred_.25 = ifelse(prob_pred > 0.25, 1, 0)
y_pred_.75 = ifelse(prob_pred > 0.75, 1, 0)


cm_.5 = table(test_set[, 3], y_pred_.5)
cm_.25 = table(test_set[, 3], y_pred_.25)
cm_.75 = table(test_set[, 3], y_pred_.75)

cm_.5
cm_.25
cm_.75
class(cm_.5)
dim(cm_.5)
missclass_.5 = (cm_.5[1,2]+cm_.5[2,1])/sum(cm_.5)
accuracy_.5  = (cm_.5[1,1]+cm_.5[2,2])/sum(cm_.5)

cm_.25
missclass_.25 = (cm_.25[1,2]+cm_.25[2,1])/sum(cm_.25)
accuracy_.25  = (cm_.25[1,1]+cm_.25[2,2])/sum(cm_.25)
 

c1 = c(.25, .5)
c2 = c( missclass_.25, missclass_.5)
c3 = c( accuracy_.25, accuracy_.5)


df_result = cbind('cutoff' = c1, 'missclass' = c2, 'accuracy' = c3)
df_result = as.data.frame(df_result)
df_result

df_result = data.frame('cutoff' = numeric(), 'miss_class' = numeric(), 'accuracy' = numeric())

# Making the Confusion Matrix
fun_cutoff = function (df_resutl, cutoff) {
    
    
    y_pred_cutoff = ifelse(prob_pred > cutoff, 1, 0)
    cm_cutoff = table(test_set[, 3], y_pred_cutoff)
    missclass_cutoff = (cm_cutoff[1,2]+cm_cutoff[2,1])/sum(cm_cutoff)
    accuracy_cutoff  = (cm_cutoff[1,1]+cm_cutoff[2,2])/sum(cm_cutoff)
    row_cutoff = c(cutoff, missclass_cutoff, accuracy_cutoff)
    
    df_result = rbind(df_result, row_cutoff)
    names(df_result) = c('cutoff', 'miss_class','accuracy')
    return(df_result)
    
}

for(i in seq(.1 , .8, .1) ) {
    
    df_result = fun_cutoff(df_result, i)
    
}
df_result = df_result[-c(1,2),]

ggplot(df_result, aes(x=cutoff, y=accuracy)) + 
    geom_line() +   
    geom_line(aes(y=miss_class), linetype = 2)

set_prob = cbind(test_set, prob_pred, y_pred_.5 )
View(set_prob)


set_prob = arrange(set_prob, desc(prob_pred) )

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

dt = lift(set_prob$Purchased  , set_prob$y_pred_.5, groups = 10)
dt

plot(dt$bucket, dt$Cumlift, type="l", ylab="Cumulative lift", xlab="Bucket")

install.packages('gains')
library(gains)

set_prob$Purchased = as.numeric(as.character(set_prob$Purchased))
gain = gains(actual = set_prob$Purchased, predicted = set_prob$prob_pred)
print.gains(gain)

 
 
 

install.packages('ROCR')
library(ROCR)

pred = prediction(set_prob$prob_pred , set_prob$Purchased)
gain = performance(pred, "tpr", "rpp")

plot(gain, col="orange", lwd=2)


plot(x=c(0, 1), y=c(0, 1), type="l", col="red", lwd=2,
     ylab="True Positive Rate", 
     xlab="Rate of Positive Predictions")
lines(x=c(0, 0.5, 1), y=c(0, 1, 1), col="darkgreen", lwd=2)

gain.x = unlist(slot(gain, 'x.values'))
gain.y = unlist(slot(gain, 'y.values'))

lines(x=gain.x, y=gain.y, col="orange", lwd=2)

summary(test_set$Purchased)




