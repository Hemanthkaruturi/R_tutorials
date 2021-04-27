library(ggplot2)
library(tidyverse)
library(corrplot)
 
setwd('C:\\Users\\600037209\\Documents\\Classes\\Data')

#Develop a multiple regression model to predict the
#world production of crude oil

oildata = read.csv('Crude Oil Production MLR.csv')
names(oildata)
View(oildata)

names(oildata) = c('W_C_Oil','US_E_Consump','US_Nuclear','US_Coal','US_Dry','US_Fuel_Rate')



str(oildata)


oilLM = lm(W_C_Oil ~ US_E_Consump+US_Nuclear+US_Coal+US_Dry+US_Fuel_Rate, data=oildata)

summary(oilLM)


# How do I plot the one output variables against many predictors ?

library(reshape2)
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


# If were to drop these four variables out of the regression analysis and 
# rerun the model with the other predictor only, what would happen to the model? 
 
# What if we ran a regression model with only three predictors? 
  
# How would these models compare to the full model with all five predictors? 
     
# Are all the predictors necessary?


# Two imporatant decision making considerations


names(oildata)
 
oilLM_1_1  = lm(W_C_Oil ~ US_E_Consump, data=oildata)
oilLM_1_2  = lm(W_C_Oil ~ US_Nuclear, data=oildata)
oilLM_1_3  = lm(W_C_Oil ~ US_Coal, data=oildata)
oilLM_1_4  = lm(W_C_Oil ~ US_Dry, data=oildata)
oilLM_1_5  = lm(W_C_Oil ~ US_Fuel_Rate, data=oildata)

attributes(oilLM_1_1)
summary(oilLM_1_1)
sum1 = summary(oilLM_1_1)
attributes(sum1)
names(sum1)
coef(sum1)
coef(sum1)[,"t value"]

coef(summary(oilLM_1_1))[, "t value"]
coef(summary(oilLM_1_1))[2, "t value"]
summary(oilLM_1_1)$r.squared

oilLM_1_1t = coef(summary(oilLM_1_1))[2, "t value"]
oilLM_1_2t = coef(summary(oilLM_1_2))[2, "t value"]
oilLM_1_3t = coef(summary(oilLM_1_3))[2, "t value"]
oilLM_1_4t = coef(summary(oilLM_1_4))[2, "t value"]
oilLM_1_5t = coef(summary(oilLM_1_5))[2, "t value"]

oilLM_1_1p = coef(summary(oilLM_1_1))[2, "Pr(>|t|)"]
oilLM_1_2p = coef(summary(oilLM_1_2))[2, "Pr(>|t|)"]
oilLM_1_3p = coef(summary(oilLM_1_3))[2, "Pr(>|t|)"]
oilLM_1_4p = coef(summary(oilLM_1_4))[2, "Pr(>|t|)"]
oilLM_1_5p = coef(summary(oilLM_1_5))[2, "Pr(>|t|)"]

oilLM_1_1rsq = summary(oilLM_1_1)$r.squared
oilLM_1_2rsq = summary(oilLM_1_2)$r.squared
oilLM_1_3rsq = summary(oilLM_1_3)$r.squared
oilLM_1_4rsq = summary(oilLM_1_4)$r.squared
oilLM_1_5rsq = summary(oilLM_1_5)$r.squared

oilLM_1_1raj = summary(oilLM_1_1)$adj.r.squared
oilLM_1_2raj = summary(oilLM_1_2)$adj.r.squared
oilLM_1_3raj = summary(oilLM_1_3)$adj.r.squared
oilLM_1_4raj = summary(oilLM_1_4)$adj.r.squared 
oilLM_1_5raj = summary(oilLM_1_5)$adj.r.squared 


indvar_1  = names(oildata)[-1]
lm_1_t    = c(oilLM_1_1t  , oilLM_1_2t  , oilLM_1_3t  , oilLM_1_4t  , oilLM_1_5t  ) 
lm_1_p    = c(oilLM_1_1p  , oilLM_1_2p  , oilLM_1_3p  , oilLM_1_4p  , oilLM_1_5p  ) 
lm_1_rsq  = c(oilLM_1_1rsq, oilLM_1_2rsq, oilLM_1_3rsq, oilLM_1_4rsq, oilLM_1_5rsq)
lm_1_raj  = c(oilLM_1_1raj, oilLM_1_2raj, oilLM_1_3raj, oilLM_1_4raj, oilLM_1_5raj)


lm_report_1 = cbind(indvar_1, round(lm_1_t,3), round(lm_1_p,3), round(lm_1_rsq,3),round(lm_1_raj,3) )
lm_report_1 = as.data.frame(lm_report_1)
names(lm_report_1) = c('Indvar' ,'t-value','p-value','R.sq', 'Adj R.sq')
lm_report_1

coef(oilLM_1_1)
summary(oilLM_1_1)


oilLM_2_1  = lm(W_C_Oil ~ US_E_Consump + US_Nuclear, data=oildata)
oilLM_2_2  = lm(W_C_Oil ~ US_E_Consump + US_Coal, data=oildata)
oilLM_2_3  = lm(W_C_Oil ~ US_E_Consump + US_Dry, data=oildata)
oilLM_2_4  = lm(W_C_Oil ~ US_E_Consump + US_Fuel_Rate, data=oildata)

 
 

oilLM_2_1t = coef(summary(oilLM_2_1))[3, "t value"]
oilLM_2_2t = coef(summary(oilLM_2_2))[3, "t value"]
oilLM_2_3t = coef(summary(oilLM_2_3))[3, "t value"]
oilLM_2_4t = coef(summary(oilLM_2_4))[3, "t value"]


oilLM_2_1p = coef(summary(oilLM_2_1))[3, "Pr(>|t|)"]
oilLM_2_2p = coef(summary(oilLM_2_2))[3, "Pr(>|t|)"]
oilLM_2_3p = coef(summary(oilLM_2_3))[3, "Pr(>|t|)"]
oilLM_2_4p = coef(summary(oilLM_2_4))[3, "Pr(>|t|)"]
 
oilLM_2_1rsq = summary(oilLM_2_1)$r.squared
oilLM_2_2rsq = summary(oilLM_2_2)$r.squared
oilLM_2_3rsq = summary(oilLM_2_3)$r.squared
oilLM_2_4rsq = summary(oilLM_2_4)$r.squared

oilLM_2_1raj = summary(oilLM_2_1)$adj.r.squared
oilLM_2_2raj = summary(oilLM_2_2)$adj.r.squared
oilLM_2_3raj = summary(oilLM_2_3)$adj.r.squared
oilLM_2_4raj = summary(oilLM_2_4)$adj.r.squared 

indvar_2 = names(oildata)[-c(1:2)]
lm_2_t    = c(oilLM_2_1t  , oilLM_2_2t  , oilLM_2_3t  , oilLM_2_4t   )
lm_2_p    = c(oilLM_2_1p  , oilLM_2_2p  , oilLM_2_3p  , oilLM_2_4p   ) 
lm_2_rsq  = c(oilLM_2_1rsq, oilLM_2_2rsq, oilLM_2_3rsq, oilLM_2_4rsq )
lm_2_raj  = c(oilLM_2_1raj, oilLM_2_2raj, oilLM_2_3raj, oilLM_2_4raj )


lm_report_2 = cbind(indvar_2, round(lm_2_t,3), round(lm_2_p,3), round(lm_2_rsq,3),round(lm_2_raj,3) )
lm_report_2 = as.data.frame(lm_report_2)
names(lm_report_2) = c('Indvar' ,'t-value','p-value' ,'R.sq', 'Adj R.sq')
View(lm_report_2)

 
summary(oilLM_2_4)
 


oilLM_3_1  = lm(W_C_Oil ~ US_E_Consump + US_Fuel_Rate + US_Nuclear, data=oildata)
oilLM_3_2  = lm(W_C_Oil ~ US_E_Consump + US_Fuel_Rate + US_Coal, data=oildata)
oilLM_3_3  = lm(W_C_Oil ~ US_E_Consump + US_Fuel_Rate + US_Dry, data=oildata)
 


oilLM_3_1t = coef(summary(oilLM_3_1))[4, "t value"]
oilLM_3_2t = coef(summary(oilLM_3_2))[4, "t value"]
oilLM_3_3t = coef(summary(oilLM_3_3))[4, "t value"]

oilLM_3_1p = coef(summary(oilLM_3_1))[4, "Pr(>|t|)"]
oilLM_3_2p = coef(summary(oilLM_3_2))[4, "Pr(>|t|)"]
oilLM_3_3p = coef(summary(oilLM_3_3))[4, "Pr(>|t|)"]
 
oilLM_3_1rsq = summary(oilLM_3_1)$r.squared
oilLM_3_2rsq = summary(oilLM_3_2)$r.squared
oilLM_3_3rsq = summary(oilLM_3_3)$r.squared
 
oilLM_3_1raj = summary(oilLM_3_1)$adj.r.squared
oilLM_3_2raj = summary(oilLM_3_2)$adj.r.squared
oilLM_3_3raj = summary(oilLM_3_3)$adj.r.squared
 
names(oildata)
indvar_3 = names(oildata)[-c(1:2,6)]
lm_3_t    = c(oilLM_3_1t  , oilLM_3_2t  , oilLM_3_3t   ) 
lm_3_p    = c(oilLM_3_1p  , oilLM_3_2p  , oilLM_3_3p   )
lm_3_rsq  = c(oilLM_3_1rsq, oilLM_3_2rsq, oilLM_3_3rsq )
lm_3_raj  = c(oilLM_3_1raj, oilLM_3_2raj, oilLM_3_3raj )


lm_report_3 = cbind(indvar_3, round(lm_3_t,3),  round(lm_3_p,3) , round(lm_3_rsq,3),round(lm_3_raj,3) )
lm_report_3 = as.data.frame(lm_report_3)
names(lm_report_3) = c('Indvar' ,'t-value', ' p-value' , 'R.sq', 'Adj R.sq')
View(lm_report_3)


summary(oilLM_1_1)
summary(oilLM_2_4)
 

AIC(oilLM_1_1)
AIC(oilLM_2_4)

library(MASS)
oilLM = lm(W_C_Oil ~ US_E_Consump+US_Nuclear+US_Coal+US_Dry+US_Fuel_Rate, data=oildata)
step = stepAIC(oilLM, direction="both")
summary(step)
step

library(caret)
train.control = trainControl(method = "cv", number = 10)
step.model = train(W_C_Oil ~., data = oildata,
                    method = "lmStepAIC", 
                    trControl = train.control,
                    trace = FALSE
)
# Model accuracy
step.model$results
# Final model coefficients
step.model$finalModel
# Summary of the model
summary(step.model$finalModel)



library(car)
vif(oilLM)
vif(oilLM_2_4)
