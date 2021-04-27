
setwd('C:/Eminent')

bnames = read.csv('bnames.csv.bz2', stringsAsFactors = F)
dim(bnames)
str(bnames)
head(bnames)

births = read.csv('births.csv')
dim(births)
str(births)
head(births)

bnames_John = bnames[  bnames$name == 'John' ,  ]
head(bnames_John)
dim(bnames_John)


head(bnames)
head(births)
library(ggplot2)
library(dplyr)

bnames_John %>% ggplot( aes(year, prop, color =sex)) + geom_point() 

bnames %>%  
         filter( sex == 'girl' & year %in% c(1900,2000) )    %>% 
         head(10)


bnames %>%  filter( name == 'Elvis') %>%  
        ggplot( aes(year, prop)) + geom_line()


bnames %>%  filter( name == 'Elvis') %>% 
            arrange( desc(prop)) %>%  head(10)
 
bnames %>%  filter(name == 'John') %>%  
            mutate( perc = prop*100) %>%  
            summarise(Avg = mean(prop),
                      Max = max(prop),
                      Min = min(prop) ) %>% round(3)
    
bnames2  = inner_join(bnames, births, by = c("year", "sex" ))
tail(bnames2)
dim(bnames2)
 
bnames2  = bnames2 %>%  mutate( n = round(prop*births) )  

bnames2 %>%  filter( name == 'John') %>% 
             summarise( Total = sum(n) )

bnames2 = bnames2 %>%  group_by(name)
head(bnames2)

bnames2 %>%  summarise( Total = sum(n) ) %>% 
             arrange( desc(Total) ) %>%  head(10) %>% 
    ggplot( aes(x=name, y=Total)) + geom_bar( stat = 'identity')

head(bnames2)
bnames2 = ungroup(bnames2)
bnames2 = group_by(bnames2, name, sex)
