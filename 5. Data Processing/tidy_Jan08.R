install.packages('reshape2')



tidy1 = read.csv('pew.csv', check.names = F)
names(tidy1)
dim(tidy1)
View(tidy1)

library(reshape2)

tidy1_melt = melt( tidy1, id="religion",
                   variable.name = "income",
                   value.name =    "count"
                   )
View(tidy1_melt)

names(tidy1_melt) = c("religion","income","count" )


raw = read.delim('weather.txt', check.names = F, na.strings = c('.') )
View(raw)
names(raw)

tidy1 = melt(raw, id=c("year","month","element" ),
             variable.name = "day",
             value.name    = "reading", 
             na.rm = T)
head(tidy1)
View(tidy1)

unique(tidy1$element)
names(tidy1)
tidy2  = dcast(tidy1,  year+month+day~element, value.var="reading")
View(tidy2)
