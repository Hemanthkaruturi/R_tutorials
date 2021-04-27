# Intution & understanding of RSE
library(ggplot2)
library(car)

addata = read.csv('Advertising.csv')

View(addata)
names(addata)

ymean = mean(addata$sales)
ymean

pl  = qplot(X, sales, data=addata) +
        geom_hline(yintercept =  ymean, color = 'red')

pl
addata$sq.dev = (addata$sales - ymean)^2
View(addata)

SST = sum(addata$sq.dev)


SST
cor(addata$sales, addata$X)
fitsalesX  = lm( sales ~ X, data= addata)
summary(fitsalesX)
coef(fitsalesX)  
sX = summary(fitsalesX)

pl1 = pl  + geom_abline(intercept = 14.49, slope = -.004653, color = 'blue')
pl1

addata$y_pred_X = predict(fitsalesX)
addata$sq.dev.X = (addata$y_pred_X - addata$sales)^2
View(addata)

sum.sq.dev.X = sum(addata$sq.dev.X)

SSRX = SST - sum.sq.dev.X  
SSRX

#Adj R.sq = 1 - ( (n-1)/(n-k-1)*(1-rsq))
# n - sample size
# k - no.of independent variables




coeff.X = SSRX/SST
coeff.X

fitsalesTV  = lm( sales ~  TV, data= addata)
summary(fitsalesTV)
coef(fitsalesTV)  
sTV = summary(fitsalesTV)


pl2 = pl1 + geom_abline(intercept = 7.0326, slope =0.04753, color='green')
pl2

addata$y_pred_TV = predict(fitsalesTV)
addata$sq.dev.TV = (addata$y_pred_TV - addata$sales)^2
View(addata)
sum.sq.dev.TV = sum(addata$sq.dev.TV)

coeff.TV = (SST - sum.sq.dev.TV)/SST
coeff.TV


#building lm on sales and X (unrelated variable)

addata$starplus = addata$TV*.3

cor(addata$TV, addata$starplus)
 
fitsales1  = lm( sales ~ X, data= addata)
summary(fitsales1)
 

smry1 = summary(fitsales1)
class(smry1)
attributes(smry1)
smry1$r.squared
smry1$adj.r.squared



fitsales2 = lm( sales ~ TV, data= addata)
summary(fitsales2)
smry2 = summary(fitsales2)

fitsales3 = lm( sales ~ X + TV, data= addata)
summary(fitsales3)
smry3 = summary(fitsales3)


fitsales4 = lm( sales ~ X + TV + starplus, data= addata)
summary(fitsales4)
smry4 = summary(fitsales4)

fitsales4b = lm( sales ~ X +  starplus + TV, data= addata)
summary(fitsales4b)
smry4b = summary(fitsales4b)

myrand = runif(200, min=-.9, max=.9)
addata$CNN = addata$TV * (1 + myrand) 

cor(addata$TV, addata$CNN)
plot(addata$TV, addata$CNN)
fitsales4c = lm( sales ~ X +  TV + CNN, data= addata)
summary(fitsales4c)
vif(fitsales4c)
AIC(fitsales4c)

    
fitsales5 = lm( sales ~ X + TV + radio, data= addata)
summary(fitsales5)
smry5 = summary(fitsales5)
vif(fitsales5)
AIC(fitsales5)



addata$myvar = sample(1:10000,200)
View(addata)

fitsales6 = lm( sales ~ X + TV + starplus + radio + myvar, data= addata)
summary(fitsales6)
smry6 = summary(fitsales6)



smry1$r.squared
smry2$r.squared
smry3$r.squared
#smry4$r.squared
smry5$r.squared
smry6$r.squared

smry1$adj.r.squared
smry2$adj.r.squared
smry3$adj.r.squared
smry4$adj.r.squared
smry5$adj.r.squared
smry6$adj.r.squared

smry1$sigma
smry2$sigma
smry3$sigma
#smry4$sigma
smry5$sigma
smry6$sigma

AIC(fitsales1, fitsales2, fitsales3)
BIC(fitsales1, fitsales2, fitsales3)


AIC(fitsales1, fitsales2, fitsales3, fitsales4, fitsales5, fitsales6)
BIC(fitsales1, fitsales2, fitsales3, fitsales4, fitsales5, fitsales6)



# check for VIF

install.packages('fmsb')
library(fmsb)


# fitsales2 = lm( sales ~ TV, data= addata)
# summary(fitsales2)
# smry2 = summary(fitsales2)

cor(addata$TV, addata$starplus)

addata$rsample = rnorm(200)
addata$CNN     = addata$TV * addata$rsample

cor(addata$TV, addata$CNN)

fitsales7 = lm( sales ~  TV + starplus, data= addata)
summary(fitsales7)
smry7 = summary(fitsales7)
 
fitsales8 = lm( sales ~   TV + starplus + radio, data= addata)
summary(fitsales8)
smry8 = summary(fitsales8)

fitsales9 = lm( sales ~   TV + starplus + CNN, data= addata)
summary(fitsales9)
smry9 = summary(fitsales9)

VIF(fitsales2)
VIF(fitsales7)
VIF(fitsales8)
