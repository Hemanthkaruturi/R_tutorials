#install.packages('sqldf')
library(lubridate)
library(ggplot2)
library(tidyverse)
library(lubridate)
library(sqldf)
library(scales)
filedir = 'C:/Users/600037209/Documents/Classes/Data'
getwd()
setwd(filedir)
getwd()
logstat = read.csv('samplog.csv', header = T)
View(logstat)
str(logstat)

#convert Rdate into date formate
logstat$Rdate  = as.Date(logstat$Rdate, format = "%d-%m-%Y")


pp = logstat %>% filter( Account %in% c('Boots')) %>% 
             select( Rdate, Rhour, Delta) 
 
 # %>% 
 #             group_by(Rdate, Rhour) %>% 
 #             summarise(total = count(Delta)) %>% 
 #             ungroup() %>% 
 #             arrange(Rdate)
View(pp)
names(pp)
class(pp$Rdate)

hrcount = sqldf('SELECT Rdate, Rhour, COUNT(*) AS hrtot FROM pp GROUP BY Rdate, Rhour')
dtcount = sqldf('SELECT Rdate, SUM(hrtot) as dttot FROM hrcount GROUP BY Rdate ')

hrcount$Rdate  = as.Date(hrcount$Rdate, format = "%d-%m-%Y")

str(hrcount)
#dtcount$Rdate  = strptime(dtcount$Rdate, "%d-%m-%Y")
dtcount$Rdate  = as.Date(dtcount$Rdate, format = "%d-%m-%Y")
View(dtcount)

dtcount$zscr = scale(dtcount$dttot, center= TRUE, scale = TRUE)
dtcount$zscr = as.numeric(dtcount$zscr)
str(dtcount)
dtcount %>% filter(zscr >= 2)

arrange(dtcount, Rdate) %>% 
    ggplot(aes(x=Rdate, y=dttot, color = zscr)) + geom_point( show.legend = F) +
    scale_color_gradient(low = "black", high = "red", limits=c(2,2.0001), oob=squish)

hist(dtcount$dttot)
boxplot(dtcount$dttot)
summary(dtcount$dttot)
str(dtcount)
 
View(hrcount)


trgdate = '2017-02-06'
sapply(dtcount, class)
hrcount$Rdate = as.Date(hrcount$Rdate)
filter(hrcount, Rdate == '2017-02-06') %>% 
ggplot(aes(x=Rhour, y=hrtot)) + 
    geom_bar(stat = 'identity', position = 'stack') +
    geom_text(aes(label = hrtot), size = 3, hjust = 0.5, vjust = 1, position =     "stack") + 
    labs(x= 'Archive Hour', y ='Archive Ount', title = paste ('Hourly Archive patterns on',trgdate))
    
xdate = '2018-02-04'
xhour = '0'

xinfo = filter(logstat, Rdate == xdate & Rhour == xhour )   
deltarow = nrow(xinfo)

    ggplot(xinfo, aes(x=1:nrow(xinfo), y=Delta)) + 
    geom_bar(stat = 'identity', position = 'stack', width = .5) + xlim (0,deltarow+1) +
    geom_text(aes(label = Delta), size = 3, hjust = 0.5, vjust = 1, position =     "stack") + 
    labs(x= 'Sequence', y ='Arch fillup Time(min)', title = paste ('Hourly Archive patterns on',trgdate)) +
    scale_y_log10()

    
    ggplot(xinfo, aes(x=1:nrow(xinfo), y=Delta)) + 
        geom_bar(stat = 'identity', position = 'stack', width = .5) + xlim (0,deltarow+1) +
        geom_text(aes(label = Delta), size = 3, hjust = 0.5, vjust = 1, position =     "stack") + 
        labs(x= 'Sequence', y ='Arch fillup Time(min)', title = paste ('Hourly Archive patterns for hour',xhour)) +
        scale_y_log10()
    
ggplot(hrcount,aes(x=Rhour, y=Rdate)) +
        geom_tile(aes(fill=hrtot)) +
        scale_fill_gradient(low = 'blue', high = 'red')

        