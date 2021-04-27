
mlrdata = read.csv('Mult_Reg_Yield.csv')

View(mlrdata)
names(mlrdata)

mymodel_temp = lm(Yield ~ Temperature , data=mlrdata)
mymodel_time = lm(Yield ~ Time , data=mlrdata)

summary(mymodel_temp)
summary(mymodel_time)

round(cor(mlrdata),2)
# Correlation between x & y should be high
# Correlation between x's should be low

# Now can you fit a model


mymodel = lm(Yield ~ Temperature + Time, data=mlrdata)
summary(mymodel)
residuals(mymodel)

# Is the Adj.Rsq >= 0.6

mymodel = lm(Yield ~  Time, data=mlrdata)
summary(mymodel)

anova(mymodel)

coef(mymodel)

pred = predict(mymodel)

mlrdata = cbind(mlrdata, pred)
res = residuals(mymodel)
mlrdata = cbind(mlrdata, res)
View(mlrdata)

mlrdata$res_cal = mlrdata$Yield - mlrdata$pred



res = residuals(mymodel)
qqnorm(res)
qqline(res)

shapiro.test(res)

 