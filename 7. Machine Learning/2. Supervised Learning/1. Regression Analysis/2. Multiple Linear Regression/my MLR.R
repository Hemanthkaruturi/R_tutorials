# importing libraries
library(corrplot)
library(ggplot2)
library(tidyverse)
library(reshape2)

#setup environment
setwd('C:/Users/600037209/Documents/Classes/Data')

#Develop a multiple regression model to predict the
#world production of crude oil

oildata = read.csv('Crude Oil Production MLR.csv')

names(oildata) = c('W_C_Oil','US_E_Consump','US_Nuclear','US_Coal','US_Dry','US_Fuel_Rate')


# How do I plot the one output variables against many predictors ?


oiltidy = melt(oildata, id = 'W_C_Oil')  


View(oiltidy)
names(oiltidy)
names(oiltidy) = c('W_C_Oil', 'predictors','value')

ggplot(oiltidy, aes(x=value, y=W_C_Oil)) +
  geom_point() +
  facet_wrap(~ predictors,  scales = 'free' ) +
  geom_smooth(method = 'glm')


# Checking the correlations


M = cor(oildata)
head(round(M,2))

corrplot(M, method = 'circle')

cor.mtest =function(mat) {
  mat = as.matrix(mat)
  n = ncol(mat)
  p.mat= matrix(NA, n, n)
  diag(p.mat) = 0
  
  for (i in 1:(n - 1)) {
    for (j in (i + 1):n) {
      # loopval =   paste('i=',i,'j=',j)
      # print(loopval)
      tmp = cor.test(mat[, i], mat[, j])
      p.mat[i, j] = p.mat[j, i] = tmp$p.value
    }
  }
  colnames(p.mat) = rownames(p.mat) = colnames(mat)
  p.mat
}
# matrix of the p-value of the correlation
p.mat=cor.mtest(oildata)
head(p.mat[, 1:4])

cor.test(oildata$W_C_Oil, oildata$US_E_Consump)
cor.test(oildata$W_C_Oil, oildata$US_Dry)



corrplot(M, type="upper", order="hclust", 
         p.mat = p.mat, sig.level = 0.05)

names(oildata)


oilLM_1_1 = lm(W_C_Oil ~ US_E_Consump+US_Nuclear+US_Coal+US_Dry+US_Fuel_Rate, data=oildata)
summary(oilLM_1_1)

oilLM_2_1 = lm(W_C_Oil ~ US_E_Consump+US_Nuclear+US_Coal+US_Fuel_Rate, data=oildata)
summary(oilLM_2_1)

oilLM_3_1 = lm(W_C_Oil ~ US_E_Consump+US_Coal+US_Fuel_Rate, data=oildata)
summary(oilLM_3_1)

oilLM_4_1 = lm(W_C_Oil ~ US_E_Consump+US_Fuel_Rate, data=oildata)
summary(oilLM_4_1)

AIC(oilLM_1_1)
AIC(oilLM_2_1)
AIC(oilLM_3_1)
AIC(oilLM_4_1)
