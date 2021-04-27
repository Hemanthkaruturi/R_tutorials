#Importing libraries
library('dplyr')
library(ggplot2)

#Importing data
data('anscombe')

#Analizing data
dim(anscombe)
View(anscombe)
summary(anscombe)

#Build linear model
model1 = lm(y1 ~ x1, data=anscombe)
summary(model1)

#finding correlation
cor(anscombe)

coef(model1)
model2 = lm(y2 ~ x2, data=anscombe)
coef(model2)
model3 = lm(y3 ~ x3, data=anscombe)
coef(model3)
model4 = lm(y4 ~ x4, data=anscombe)
coef(model4)

pairs(anscombe)

#Visualizing data using ggplot
anscombe %>% ggplot(aes(x1, y1)) + geom_point()+ geom_smooth(method = 'lm')
anscombe %>% ggplot(aes(x2, y2)) + geom_point()+ geom_smooth(method = 'lm')
anscombe %>% ggplot(aes(x3, y3)) + geom_point()+ geom_smooth(method = 'lm')
anscombe %>% ggplot(aes(x4, y4)) + geom_point()+ geom_smooth(method = 'lm')

plot(anscombe$x1, anscombe$y1)
plot(anscombe$x2, anscombe$y1)
plot(anscombe$x3, anscombe$y1)
plot(anscombe$x4, anscombe$y4)
