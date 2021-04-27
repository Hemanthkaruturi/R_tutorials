#set working directory
setwd('C:/Users/600037209/Documents/Classes/Data')

#import data
df <- read.csv('Boston_housing_train.csv')

#manual standardization
df_stand <- df
df_stand['crim'] <- (df$crim - mean(df$crim)) / sd(df$crim)

#manual normalization
df_norm <- df
df_norm['crim'] <- (df$crim - min(df$crim)) / (max(df$crim - min(df$crim)))

#Standardization using scale function
df_standard <- scale(df)
names(df_standard) <- names(df)
df_standard <- data.frame(df_standard)
