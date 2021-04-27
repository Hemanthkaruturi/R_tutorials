# import data
data <- read.csv('C:\\Users\\600037209\\Documents\\Classes\\Data\\Financial Sample.csv')
names(data)
str(data)


v = c(' Eminent ',' IT ')
trimws(v)

data['Manufacturing.Price'] <- trimws(gsub('\\$','',data$Manufacturing.Price))
data['Sale.Price'] <- trimws(gsub('\\$','',data$Sale.Price))
data['Gross.Sales'] <- trimws(gsub('\\$','',data$Gross.Sales))
data['Gross.Sales'] <- trimws(gsub('\\,','',data$Gross.Sales))
data['Discounts'] <- trimws(gsub('\\$','',data$Discounts))
data['Discounts'] <- trimws(gsub('\\-','',data$Discounts))
data['Discounts'] <- trimws(gsub('\\,','',data$Discounts))
data['Sales'] <- trimws(gsub('\\$','',data$Sales))
data['Sales'] <- trimws(gsub('\\,','',data$Sales))
data['COGS'] <- trimws(gsub('\\$','',data$COGS))
data['COGS'] <- trimws(gsub('\\,','',data$COGS))
data['Profit'] <- trimws(gsub('\\$','',data$Profit))
data['Profit'] <- trimws(gsub('\\,','',data$Profit))
data['Profit'] <- trimws(gsub('\\,','',data$Profit))
data['Profit'] <- trimws(gsub('\\(','',data$Profit))
data['Profit'] <- trimws(gsub('\\)','',data$Profit))

# data converision
data['Manufacturing.Price'] <- as.numeric(data$Manufacturing.Price)
data['Sale.Price'] <- as.numeric(data$Sale.Price)
data['Gross.Sales']<- as.numeric(data$Gross.Sales)  
data['Discounts'] <- as.numeric(data$Discounts)
data['Sales']<- as.numeric(data$Sales)

#converting date
data['Date'] <- as.Date(data$Date, format='%d-%m-%Y')
str(data)
data['Year'] <- format(data$Date, '%Y')
format(data$Date, '%m')
format(data$Date, '%B')
format(data$Date, '%d')
data['Days'] <- format(data$Date, '%A')

days <- c('Saturday','Sunday')
weekday_or_weekend <- c()
for (i in 1:length(data$Days)){
  if (data$Days[i] %in% days){
    weekday_or_weekend[i] <- 'Weekend'
  }else{
    weekday_or_weekend[i] <- 'Weekday'
  }
}

data['Weekday_weekend'] <- weekday_or_weekend


## dplyr
library(dplyr)

#select()
#filter()
#summarise()
#mutate()
#group_by()
#arrange()
#sample_frac()

data[,-c(1,2)]
select(data, -c(1,2))
names(data)
select(data, ends_with('Price'))
select(data, starts_with('Sale'))

filter(data, (Units.Sold>2000)&(Country == 'Canada'))
filter(data,  Country %in% c('Canada','Germany'))
summarise(data, average = mean(Units.Sold), minimum = min(Units.Sold),maximum = max(Units.Sold),Total = sum(Units.Sold))
data <- mutate(data, net_units=data$Units.Sold/sum(data$Units.Sold)*100)

str(data)
data['Profit'] = as.numeric(data$Profit)

HMISC_data %>% select(Segment,Profit,Year) %>% group_by(Segment,Year) %>% summarise(Total = sum(Profit)) %>% arrange(desc(Total))

#data[['Segment','Profit']].groupby('Segment').sum(Total=sum(Profit))
library(dplyr)
HMISC_data %>% select(Country,Profit,Year) %>% group_by(Country,Year) %>% summarise(Total_profit = sum(Profit)) %>% filter(Country=='Germany') %>% arrange(desc(Total_profit)) %>% head(1) %>% select(Year)

#data.isnull().sum()
colSums(is.na(data))

data[is.na(data$Profit),]
data[is.na(data$Discounts),]
data[!is.na(data$Discounts),]

data['Profit'][is.na(data$Profit),] <- mean(data$Profit, na.rm = TRUE)
data['Discounts'][is.na(data$Discounts)] <- mean(data$Discounts, na.rm = TRUE)

library(mice)
md.pattern(data)

library(VIM)

vis_mis <- aggr(data)

set.seed(50)

imp_mice_data <- mice(data[c('Profit','Discounts')], m=5, maxit = 10, method = 'pmm',seed=50)

imputed_mice_data <- imp_mice_data$imp$Discounts[5]

data['Discounts'][is.na(data$Discounts),] <- imputed_mice_data

colSums(is.na(data))


library(Amelia)
colSums(is.na(data))
Amelia_data <- data

imp_amelia <- amelia(Amelia_data[c('Profit','Discounts')],m=5,parallel = 'multicore')
imp_amelia

imp_amelia$imputations$imp3

Amelia_data[c('Profit','Discounts')] <- imp_amelia$imputations$imp3
colSums(is.na(Amelia_data))


library(Hmisc)

HMISC_data <- data

imp_hmisc <- aregImpute(~Profit+Discounts, data=HMISC_data, n.impute = 4)
imp_hmisc
imp_hmisc$imputed

HMISC_data['Profit'][is.na(data$Profit),] <- imp_hmisc$imputed$Profit[,5]
HMISC_data['Discounts'][is.na(data$Discounts),] <- imp_hmisc$imputed$Discounts[,5]
colSums(is.na(HMISC_data))

library(missForest)
miss_data <- data

str(miss_data)

class(miss_data[c('Profit','Discounts')])
m_data <- miss_data[,1:9]

imp_miss_data <- missForest(m_data)
View(m_data)

miss_data <- imp_miss_data$ximp

colSums(is.na(miss_data))

t = tibble(x=1,y=2)
t['x']
d = data.frame(x=c(1,2,3,4),y=c(3,2,1,4))
d
t = tibble(x=c(1,2,3,4),y=c(3,2,1,4))
t
t['x']
t[2:3,1]

miss_tibble <- tibble(miss_data)
miss_tibble
miss_data
head(miss_data,10)
tail(miss_data)


t <- tibble(x=list(1,2,3,4),y=list(3,2,1,4))
t

t$x
t$y
d <- data.frame(x=list(1,2,3,4),y=list(4,2,4,1))
d

library(data.table)

data <- fread('C:\\Users\\600037209\\Documents\\Classes\\Data\\Financial sample.csv',stringsAsFactors = TRUE)
names(data)

head(data[,'Segment'])
tail(data)

data[,c('Segment','Units Sold')]
str(data)


# convert factors to numeric
str(data)
unlist(data$Segment)

levels(data$Segment)
labels(data$Segment)

factor(data$Segment, levels = c('Government','Enterprise','Midmarket','Channel Partners','Small Business'), labels=c(1,2,3,4,5))

library(dplyr)
distinct(data['Country'])

factor(data$Country, levels = c('Canada','Germany','France','Mexico','United States of America'), labels = c(1,2,3,4,5))

data = rename(data, Discount.Brand=Discount.Band)

emp_id = c(123,124,125,126)
emp_name = c('Rajesh','Rakesh','Ram','Ravi')
emp_age = c(27,29,43,32)
emp_details = data.frame(emp_id,emp_name,emp_age)

emp_salary = c(10.3,3.4,5,7)
emp_sal = data.frame(emp_id,emp_salary)

merge(emp_details,emp_sal,by.x = 'emp_id',by.y = 'emp_id','Left')

library(sqldf)

sqldf('select d.emp_name,s.emp_salary from emp_details d left join emp_sal s on d.emp_id=s.emp_id')
sqldf('select Segment,"Units.Sold" from data')

sqldf('Select Segment,"Units.Sold" from data where "Units.Sold" > 3000')

data1 <- fread('C:\\Users\\600037209\\Documents\\Classes\\Data\\Financial Sample.csv', stringsAsFactors = T)

price = c(22,23,12,45)
units = c(3,2,4,1)
products = data.frame(price,units)

apply(products, 2, max)

fun <- function(x){
  return (x[1]*x[2])
}

products['Revenue'] = apply(products,1,fun)

products['Revenue'] = products$price * products$units

fun1 <- function(x){
  print(x)
}

lapply(products,fun1)
sapply(products, sum)

x = c(1,2,3,4)
y = c(3,4,5,2)
plot(x,y)
d <- data.frame(x,y)

library(ggplot2)

ggplot(data,aes(x=Segment))+ geom_bar()



