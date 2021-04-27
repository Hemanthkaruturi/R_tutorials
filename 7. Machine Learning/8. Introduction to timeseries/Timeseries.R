install.packages('forecast')
install.packages('fpp2')

library(forecast)
library(ggplot2)
library(fpp2)
 
set.seed(3)
wn = ts(rnorm(36))
autoplot(wn)
ggAcf(wn)
frequency(wn)

data('a10')
head(a10)
View(a10)
class(a10)
length(a10)

autoplot(a10)
frequency(a10)
ggseasonplot(a10)
ggseasonplot(a10,polar = T)
ggsubseriesplot(a10)

autoplot(ausbeer)
class(ausbeer)
length(ausbeer)

beer = window(ausbeer, start=1992)
autoplot(beer)
frequency(beer)
ggseasonplot(beer)
ggsubseriesplot(beer)


autoplot(oil)
frequency(oil)
autoplot(gold)
frequency(gold)
autoplot(gas)
frequency(gas)

View(oil)

ggseasonplot(gas)
ggsubseriesplot(gas)

autoplot(oil)
ggAcf(oil)

autoplot(gas)
ggAcf(gas)

autoplot(gold)
ggAcf(gold)

gglagplot(gold)

length(ausbeer)
fcbeer = snaive(ausbeer, h=16)
autoplot(fcbeer)

args(ses)
