#install.packages('DAAG')
#install.packages('MASS')
library(DAAG)
library(MASS)
library(caret)


oildata = read.csv('Crude Oil Production MLR.csv')
names(oildata)
View(oildata)

dim(oildata)
names(oildata) = c('W_C_Oil','US_E_Consump','US_Nuclear','US_Coal','US_Dry','US_Fuel_Rate')

boxplot(oildata)

oil_model  = lm(W_C_Oil ~ US_E_Consump + US_Fuel_Rate, data=oildata)
summary(oil_model)

res = residuals(oil_model)
mse = mean(res^2)
rmse = sqrt(mse)
rmse
mse
 
kfold = cv.lm(oil_model,data=oildata,m=3)
head(kfold,10)


cv_fold1 = oildata[-c( 1,9,12,14,15,20,22,25), ]
cv_fold1_test = oildata[c( 1,9,12,14,15,20,22,25), ]
oil_model_cvf1  = lm(W_C_Oil ~ US_E_Consump + US_Fuel_Rate, data=cv_fold1)
summary(oil_model_cvf1)

pred_cvf1  = predict(oil_model_cvf1, newdata = cv_fold1_test)

res =  pred_cvf1 - cv_fold1_test$W_C_Oil
mse = mean(res^2)
rmse = sqrt(mse)
rmse
mse
