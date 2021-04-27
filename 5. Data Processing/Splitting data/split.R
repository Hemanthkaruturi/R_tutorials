#set working directory
setwd('C:/Users/600037209/Documents/Classes/Data')

#import data
df <- read.csv('Boston_housing_train.csv')

#splitting data to train and test
library(caTools)
set.seed(100)
sample = sample.split(df$medv, SplitRatio = 0.80)
train = subset(df, sample==TRUE)
test = subset(df, sample==FALSE)
