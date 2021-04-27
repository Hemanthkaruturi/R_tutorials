library(ggplot2)
library(dplyr)
filedir = 'C:/Eminent'
setwd(filedir)
bnames = read.csv("bnames.csv.bz2", stringsAsFactors = F)
births = read.csv("births.csv", stringsAsFactors =  F)

View(bnames)
View(births)
garrett = bnames[bnames$name == "Garrett", ]
View(garrett)
qplot(year, prop, data = garrett, geom = "line")
class(bnames$name)

michael = bnames[bnames$name == "Michael", ]
qplot(year, prop, data = michael, geom = "line")
qplot(year, prop, data = michael, geom = "point")
library(sqldf)
temp1 = sqldf('select * from bnames where name = "Garrett" ')
dim(temp1)

temp2 = arrange(bnames, desc(prop) )
View(temp2)
temp3 = arrange(bnames, desc(prop,year) )
View(temp3)

bnames = mutate(bnames, perc = prop*100 )
names(bnames)


df_john = filter(bnames, name == 'John') 
summarise(df_john, max(prop), min(prop), mean(prop))

filter(bnames, name == 'John') %>% 
    summarise( max(prop), min(prop), mean(prop) )

head(bnames, 20)
bnames %>% head(20)
filter(bnames, name == 'John' , year == 1890)

browseVignettes(package = "dplyr")

qplot(year, births, data=births, geom = 'line',color = sex)

         bnames2 = left_join(bnames, births, by = c('year','sex') )
head(bnames2)
class(bnames2)
tbnames2 = mutate(bnames2, n = prop*births)
bnames2 = mutate(bnames2, n = round(prop*births) )

filter(bnames2, name == 'John') %>% summarise( Tot_John = sum(n) )

group_by(bnames2, name) %>% summarise(tot = sum(n) ) %>%  arrange(desc(tot) )

bnames2 = group_by(bnames2, name)
bnames2

jdf = bnames2 %>%  filter( name == 'John') 
View(jdf)

%>% summarise( min(prop) )

bnames2 %>% filter( sex =='girl',year < 1950,)    %>% 
            group_by(name)           %>% 
            summarise(tot = sum(n) ) %>%  
            arrange( desc(tot) ) 

class(bnames2)
bnames2
bnames2 = ungroup(bnames2)

bnames2 %>% group_by(soundex)  %>% 
    summarise(tot = sum(n) ) %>%  
    arrange( desc(tot) ) 
 bnames2 %>%  filter( soundex == 'J500') )  
