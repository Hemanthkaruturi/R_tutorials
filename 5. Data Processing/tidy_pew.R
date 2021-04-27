
setwd('C/Eminent')

pewdata = read.csv('pew.csv', check.names = F)
View(pewdata)
names(pewdata)


library(reshape2)
tidy = melt(pewdata, id = "religion",
            value.name = 'count',
            variable.name = 'Income')

View(tidy)
names(tidy) =c("religion","Income","count" )

tempdata = read.delim('weather.txt', na.strings = '.', check.names = F)
View(tempdata)
names(tempdata)
tidymelt = melt(tempdata, id = c( "year" ,"month","element"), 
                variable.name = 'day',
                value.name =  'reading',
                na.rm = T)
View(tidymelt)
names(tidymelt)
tidy = dcast(tidymelt,  year+month+day ~ element, 
             value.var = 'reading')
View(tidy)
