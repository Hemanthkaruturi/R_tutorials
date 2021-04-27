library(ggplot2)
library(ggthemes)
library(plotly)
options(scipen=999)

str(Sales_full_data)
names(Sales_full_data)

#boxplot
p <- ggplot(Sales_full_data, aes(y=`Sales`)) + geom_boxplot() + labs(x='Sales Bucket',title = 'Sales buket frequency',subtitle = 'Just a boxplot',caption = 'Made with ggplot2')
ggplotly(p)
##bar graph
p <- ggplot(Sales_full_data, aes(x=`Sales-Bucket`)) + geom_bar()
names(Sales_full_data)
ggplotly(p)

#scatterplot
p <- ggplot(Sales_full_data, aes(x=`Total households`, y=`Sales`, colour=`Sales-Bucket`)) + geom_point() + labs(x='Total households',y='Sales',title='Total households vs Sales') + theme_tufte()
ggplotly(p)

ggplot(Sales_full_data, aes(x=`Sales`)) + geom_density()

head(Sales_full_data)

p <- Sales_full_data %>% arrange(by=Sales) %>% tail(10) %>% ggplot(aes(x = `Neighbourhood`, y = Sales)) + geom_point()
ggplotly(p)

