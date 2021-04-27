library(corrplot)
library(ggplot2)
library(tidyverse)
library(corrplot)


#Develop a multiple regression model to predict the
#world production of crude oil
setwd('C:/Users/600037209/Documents/Classes/Data')
oildata = read.csv('Crude Oil Production MLR.csv')
names(oildata)

names(oildata) = c('W_C_Oil','US_E_Consump','US_Nuclear','US_Coal','US_Dry','US_Fuel_Rate')



str(oildata)




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


oilLM_fuel = lm(W_C_Oil ~ US_Fuel_Rate, data=oildata)
summary(oilLM_fuel)

oilLM_coal = lm(W_C_Oil ~ US_Coal, data=oildata)
summary(oilLM_coal)

oilLM_fuel_coal = lm(W_C_Oil ~ US_Fuel_Rate+ US_Coal, data=oildata)
summary(oilLM_fuel_coal)

oilLM_fuel_coal_int = lm(W_C_Oil ~ US_Fuel_Rate+ US_Coal+US_Coal:US_Fuel_Rate, data=oildata)
summary(oilLM_fuel_coal_int)

coalLM_vif = lm(US_Coal ~ US_E_Consump+US_Nuclear+US_Dry+US_Fuel_Rate, data=oildata)
summary(coalLM_vif)

# VIF = 1 / (1 - Rsq)
# 1/(1-.9442) = 17.92

library(car)

oilLM_all = lm(W_C_Oil ~ US_E_Consump+US_Nuclear+US_Coal+US_Dry+US_Fuel_Rate, data=oildata)
vif(oilLM_all)

oilLM_2_4 = lm(W_C_Oil ~ US_E_Consump+US_Fuel_Rate, data=oildata)
vif(oilLM_2_4)

 

