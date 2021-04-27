raw = read.csv('pew.csv', check.names = F)
View(raw)


library(reshape2)

tidy = melt(raw, id='religion')

View(tidy)

summary(tidy)

raw <- read.delim("weather.txt", check.names = F, na.strings = ".")
View(raw)
names(raw)

raw = melt(raw, id = c("year"  ,  "month" ,  "element"), variable.name = "days", na.rm = T )
View(raw)
names(raw)

raw = raw[ , c("year"   , "month", "days" , "element"   ,  "value" )]
View(raw)
tidy= dcast(raw, year + month + days ~ element, value.var = "value")
View(tidy)


bnames = read.csv('bnames.csv.bz2')
dim(bnames)

diamonds 


titanic = read.csv('titanic2.csv', stringsAsFactors = F)
summary(titanic)
class(titanic$fate)

View(titanic)

names(titanic)

titanic$comments = NULL


tidy <- melt(titanic, id = c("class", "age", "fate"),
             variable.name = "gender")
tidy <- dcast(tidy, class + age + gender ~ fate,
              value.var = "value")

View(tidy)

tidy$sruv_rate = tidy$survived/(tidy$perished+ tidy$survived)

tidy$sruv_rate = round(tidy$sruv_rate,2)
