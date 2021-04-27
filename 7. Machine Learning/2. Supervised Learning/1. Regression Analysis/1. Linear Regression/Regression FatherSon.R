# library(reshape2)
# library(psych)
# install.packages('mosaic')
# library(mosaic)
  library(ggplot2)
# library(useful)
  
#set working environment
setwd('C:/Users/600037209/Documents/Classes/Data')

names(htdata)
 
htdata  = read.csv('FatherSon.csv')
View(htdata)

cor(htdata$fheight, htdata$sheight)

ggplot(htdata, aes(x = fheight, y = sheight)) + geom_point()

ggplot(htdata, aes(x = fheight, y = sheight)) + 
    geom_point() +
    geom_smooth(method = 'lm')


class(sheight ~ fheight)
#linear model Son's height is output/response/y  and father's height is input/predictor/x or x   
height1 = lm(formula=sheight ~ fheight, data = htdata)
summary(height1)
attributes(height1)
height1$residuals
 
res = height1$residuals

#Display the model coeff or weights
height1


33.8866 + 0.5141 * 60
# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(htdata$sheight, SplitRatio = 2/3)
training_set = subset(htdata, split == TRUE)
test_set = subset(htdata, split == FALSE)
dim(training_set)
dim(htdata)
# Feature Scaling
# training_set = scale(training_set)
# test_set = scale(test_set)

# Fitting Simple Linear Regression to the Training set
regressor = lm(formula = sheight ~ fheight,
               data = training_set)
summary(regressor)

# Predicting the Test set results
y_pred = predict(regressor, newdata = test_set)

# Visualising the Training set results
library(ggplot2)
ggplot() +
    geom_point(aes(x = training_set$fheight, y = training_set$sheight),
               colour = 'red') +
    geom_line(aes(x = training_set$fheight, y = predict(regressor, newdata = training_set)),
              colour = 'blue') +
    ggtitle('Son Height vs Father Height (Training set)') +
    xlab('Father Height') +
    ylab('Son Height')

# Visualising the Test set results
library(ggplot2)
ggplot() +
    geom_point(aes(x = test_set$fheight, y = test_set$sheight),
               colour = 'red') +
    geom_line(aes(x = training_set$fheight, y = predict(regressor, newdata = training_set)),
              colour = 'blue') +
    ggtitle('Son Height vs Father Height (Test set)') +
    xlab('Father Height') +
    ylab('Son Height')


htdata$pred =  predict(height1)
htdata$residual = htdata$sheight - htdata$pred
htdata$sq.residual = htdata$residual^2

htdata$meanmodel_diff = htdata$sheight - mean(htdata$sheight)
htdata$sq.meanmodel_diff = htdata$meanmodel_diff^2
 
SSE  = sum(htdata$sq.residual)
SST  = sum(htdata$sq.meanmodel_diff)
r.sq = 1 -(SSE/SST)

View(htdata)

sum(htdata$sq.residual)

res = height1$residuals
qqnorm(res)
qqline(res)
shapiro.test(res)

plot(htdata$fheight, res)
