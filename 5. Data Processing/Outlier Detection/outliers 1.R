#import libraries
library(ggplot2)

#set working directory
setwd('C:/Users/600037209/Documents/Classes/Data')

#import data
df <- read.csv('Boston_housing_train.csv')

#explore data
head(df)
dim(df)

#univariate analysis
boxplot(df['medv'])
## or ##
ggplot(df, aes(y=df$medv)) + geom_boxplot()

ggplot(df, aes(x=df$medv)) + geom_density()

#bivariate analysis
ggplot(df, aes(x=df$medv, y=df$tax)) + geom_point()

#removing outliers using z score
abs(scale(df))

threshold = 3
df_z = df
df_z[abs(scale(df_z)) > threshold] <- NA
colSums(is.na(df_z))
df_z = na.omit(df_z)

#Observe values after removing outliers
#Before deleting outliers
ggplot(df, aes(y=df$zn)) + geom_boxplot()
#After deleting outliers
ggplot(df_z, aes(y=df_z$zn)) + geom_boxplot()

#removing outliers using IQR
Q1 = quantile(df$medv, c(0.25))
Q3 = quantile(df$medv, c(0.75))
IQR = Q3 - Q1

extreme.threshold.upper = IQR * 1.5 + Q3
extreme.threshold.lower = Q1 - IQR*1.5

df_iqr <- df[which(df$medv < extreme.threshold.lower),]
df_iqr <- df_iqr[which(df$medv > extreme.threshold.upper),]
df_iqr <- na.omit(df_iqr)
#do it same for all the variables

#observe values after removing ouliers
ggplot(df_iqr, aes(y=df_iqr$medv)) + geom_boxplot()

# remove outliers which are out at mean absolute standard deviation
abs(df$medv - mean(df$medv))
sd(df$medv)
names(df)
df_std <- df[abs(df$medv - mean(df$medv)) <= (sd(df$medv)),]

#observe values after removing ouliers
#Before
ggplot(df, aes(y=df$medv)) + geom_boxplot()
#After
ggplot(df_std, aes(y=df_std$medv)) + geom_boxplot()

#remove outliers using DMwR
library(DMwR)
outlier.scores <- lofactor(df, k=5)
plot(density(outlier.scores))
order(outlier.scores, decreasing=T)[1:5]
#Visualising outliers
n <- nrow(df)
labels <- 1:n
labels[-outliers] <- "."
biplot(prcomp(df), cex=.8, xlabs=labels)