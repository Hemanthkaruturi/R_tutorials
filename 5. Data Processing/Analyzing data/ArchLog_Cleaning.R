
library(lubridate)
library(ggplot2)
library(tidyverse)
library(lubridate)

       
logstat = read.csv('samplog.csv', header = T)
View(logstat)


logstat = read.delim('logstats.txt', sep = ' ', header = F)
View(logstat)

#Removing the top row
logstat = logstat[-1,  ]
head(logstat)

#Naming the columns
names(logstat) = c('ReadDate','del1','xtra', 'ReadTime')

#compact display the structure of dataframe
str(logstat)

#converting the from factor to charcter
logstat$xtra = as.character(logstat$xtra)

#Displaying the non-empty data 
filter(logstat , xtra != '')
 

#combing the 2 coulmns 
logstat$ReadTime = paste(logstat$ReadTime, logstat$xtra, sep='')

#Displaying the non-empty data now copied to ReadTime column
filter(logstat , xtra != '')

#Selecting the required columns
logdata = logstat %>% select(ReadDate, ReadTime)

#combining Date & Time
logdata$ReadTS_Int = paste(logdata$ReadDate, logdata$ReadTime)

#Display the class of object
class(logdata$ReadTS_Int)

# converting from char to POSIX class of date & time
logdata$ReadTS = strptime(logdata$ReadTS_Int, "%Y.%j %H:%M")

#Display the class of object
class(logdata$ReadTS)

# Taking the time difference of 2 consequtive radings
# We need to omit the last record as the difference cant be calculated
logdata$Delta = 0
lastrow = nrow(logdata) 

for (i in 2:lastrow) {
 logdata$Delta[i] = difftime(logdata$ReadTS[i] , logdata$ReadTS[i-1], units = c('mins')) 
  
}

# Dislay the first & last  5 records
tail(logdata, 5)
head(logdata, 5)
#Removing the top row
logdata = logdata[-1,  ]
head(logdata, 5)

 
str(logdata) 

# Deriving the dimensions
logdata$Rhour = hour(logdata$ReadTS)
logdata$Rdate = date(logdata$ReadTS)
logdata$Rday  = weekdays(logdata$Rdate)
logdata$Rcomb = paste(logdata$Rdate, logdata$Rday)
logdata$Rdate = as.factor(logdata$Rdate)

View(logdata)


logdata %>% ggplot(aes(x=ReadTS, y=Delta)) + 
              geom_point() +
              geom_smooth(method='lm') +
              facet_wrap( ~ Rhour, ncol=4) +
              ggtitle('Hourly Patterns') +
              ylab('Log content in Min') + xlab('Date')


logstat %>% ggplot(aes(x=seq(1:nrow(logstat)), y=delta)) + 
  geom_line()  
  

geom_smooth(method='lm') +
  facet_wrap( ~ xhour, ncol=4) +
  ggtitle('Production Archive Log Hourly Patterns') +
  ylab('Log content in Min') + xlab('Date')

samp3 = logstat[1:5,]

samp3$Xdate = date(samp3$Xtime2)

logstat %>%  ggplot(aes(x=Xhour, y=delta, color ='red')) + 
                geom_bar(stat = 'identity', position = 'stack') +
                facet_wrap(~Xdate)


logdata %>%  ggplot(aes(x=Rhour, y=Delta, color ='red')) + 
  geom_bar(stat = 'identity', position = 'stack') +
  facet_wrap(~Rday, ncol = 7)


funDateBet <- function(x,y){logdata[logdata$ReadTS >= x & logdata$ReadTS <= y,]}


DATE1 <- as.Date("2018-02-12")
DATE2 <- as.Date("2018-03-12")



df_1month  <- funDateBet(DATE1,DATE2)    
 
df_1month %>%  ggplot(aes(x=Xhour, y=delta, color ='red')) + 
  geom_bar(stat = 'identity', position = 'stack', fill='white') +
  facet_wrap(~Xcomb, ncol = 7) +
  scale_y_log10()


# for count
df_1month %>%  ggplot(aes(x=Rhour, color ='red')) + 
  geom_bar() +
  facet_wrap(~Rcomb, ncol = 7)  



df_Wkday = subset(df_1month, Rday %in% c('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'))
df_Wkend = subset(df_1month, Rday %in% c('Saturday', 'Sunday'))
df_Mon   = subset(df_1month, Rday %in% c('Monday'))



df_Wkday %>%  ggplot(aes(x=Rhour, y=Delta, color ='red')) + 
  geom_bar(stat = 'identity', position = 'stack', fill='white') +
      facet_wrap(~Rcomb, ncol = 5) +
    ggtitle(' Log Hourly Patterns') +
  ylab('Log content in Min') + xlab('Hour of Day') +
    theme(legend.position="none")

df_Wkend %>%  ggplot(aes(x=Rhour, y=Delta, color ='red')) + 
  geom_bar(stat = 'identity', position = 'stack', fill='white') +
  facet_wrap(~Rcomb, ncol = 2) +
  ggtitle('Log Hourly Patterns') +
  ylab('Log content in Min') + xlab('Hour of Day') +
  theme(legend.position="none")

View(logdata)

write.csv(logdata,'samplog.csv', row.names = FALSE)

unqact = unique(logstat$Account)


