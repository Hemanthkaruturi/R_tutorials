# 3 types of dates in R

# Date
# POSIXct - moslty used - which stores seconds since UNIX epoch (+some other data) 
# POSIXlt - which stores a list of day, month, year, hour, minute, second, etc

install.packages('lubridate')
install.packages('Hmisc')

library(lubridate)
library(Hmisc)

Sys.time()
class(Sys.time())

dt1 = '2018-04-07'
dt2 = '06 April 2018'
dt3 = '4-5-18'
dt4 = 'April 3rd 2018'
dt5 = '2018-04-07 23:45:27'

class(dt1)


dt1x = ymd(dt1)
class(dt1x)

dt1y = ymd(dt1, tz = 'UTC')
class(dt1y)

dt2y = dmy(dt2, tz='UTC')
class(dt2y)

dt3y = mdy(dt3, tz='UTC')
class(dt3y)

dt4y = mdy(dt4, tz='UTC')
class(dt4y)

dt5y = ymd_hms(dt5, tz='UTC')


# Extracting the day, week, month

day(dt1y)
month(dt2y)
months(dt3y)
week(dt4y)
weekdays(dt5y)
quarter(dt1y)
 

#difference between times

dt1y - dt3y

dif = dt5y - dt4y
class(dif)

dif = as.numeric(dif)
class(dif)


difftime(dt1y, dt3y, unit='sec')

x = difftime(dt1y, dt3y, unit='min')
class(x)

# number of days in a month
monthDays(dt1y)

yearDays(dt5y)

# strptime is a function to directly convert character vectors 
# (of a variety of formats) to POSIXlt format

x = c("2018.035", "2018.036", "2018.002", "2017.365")
class(x)

y = strptime(x, '%Y.%j')
y
class(y)
x = c('2018-04-07 23:14:53' , '2018-04-06 00:23:20', '2018-03-04 13:51:21')
y = strptime(x, '%Y-%m-%d %H:%M:%S')
y    
