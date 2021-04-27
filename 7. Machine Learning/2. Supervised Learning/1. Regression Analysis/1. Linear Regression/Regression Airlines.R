install.packages('MASS')
library(MASS)

#set working environment
setwd('C:/Users/600037209/Documents/Classes/Data')

airdata = read.csv('Passenger.csv')
View(airdata)

names(airdata)

names(airdata) = c("Passengers" ,"Cost" )
attach(airdata)
detach(airdata)

cor(airdata$Passengers, airdata$Cost)
cor(airdata$Cost, airdata$Passengers)

costfit = lm(Cost ~ Passengers, data =airdata)
summary(costfit)

plot(airdata$Passengers, airdata$Cost)
abline(costfit)


plot(costfit)

par(mfrow=c(2,2))
plot(costfit)

res = residuals(costfit)
pred = predict(costfit)
qqnorm(res)
coef(costfit)

anova(costfit)    
