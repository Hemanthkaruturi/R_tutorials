setwd('C:/Users/600037209/Documents/Data Science Material/Data Science Material/Data')

bnames = read.csv('bnames.csv.bz2', stringsAsFactors = F)
births = read.csv('births.csv', stringsAsFactors = F)

head(bnames)
head(births)

bname_John = bnames[bnames$name == 'John',]
dim(bname_John)

library(ggplot2)
qplot(x=year, y=prop, data=bname_John, color = sex) + geom_point()


head(bnames,10)
bnames %>% head(10)        

filter(bnames, name == 'John')    
bnames %>% filter(name == 'John' & sex == 'girl')
    