library(ggplot2)
library(ggthemes)

str(data)

ggplot(data, aes(y=data$Gross.Sales)) + geom_boxplot()
ggplot(data, aes(x=data$Gross.Sales)) + geom_density() + xlab('Gross Sales')
ggplot(data, aes(x=data$Gross.Sales)) + geom_histogram()

ggplot(data, aes(x=data$Sale.Price, y=data$Sales)) + geom_point() + theme_excel()

bank_data = read.csv('C:\\Users\\600037209\\Documents\\Classes\\Data\\bank-full.csv', sep=';')

ggplot(bank_data, aes(x =age, y =balance, color=marital)) + geom_point()

library(dplyr)
bank_data %>% select(marital,balance) %>% group_by(marital) %>% summarise(Total_balance=sum(balance)) %>% ggplot(aes(x=marital,y=Total_balance)) + geom_bar(stat = 'identity') 

data %>% select(Sales,Date) %>% group_by(Date) %>% summarise(Total_sales=sum(Sales)) %>% filter(Date >= '2014-01-01')%>% ggplot(aes(x=Date,y=Total_sales)) + geom_smooth()

data %>% select(Segment,Sales) %>% group_by(Segment) %>% summarise(Total_sales=sum(Sales)) %>% ggplot(aes(x=Segment,y=Total_sales)) + geom_bar(stat='identity', color='black',fill='red') + geom_text(aes(label=Total_sales), vjust=1.5, color='white') +theme_bw()

options(scipen = 999)

