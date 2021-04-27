setwd('C:/Eminent')

bnames  = read.csv('bnames.csv.bz2')
births  = read.csv('births.csv')

View(bnames)
View(births)
names(bnames)
names(births)
library(dplyr)
library(ggplot2)

bnames %>%  
    filter(name == 'Robert') %>%  
    arrange(desc(prop) )   %>% head(10)

bnames = bnames %>% mutate(perc = prop*100) 

bnames %>% filter(name == 'John') %>% 
    summarise( Min = min(prop),
               Max = max(prop),
               Avg = mean(prop) )

bnames = inner_join(bnames, births, by = c('year','sex') )  

bnames = bnames %>%  mutate(name_count = round(prop*births))  

bnames %>%  
    filter(name == 'John') %>% 
    summarise(Min = min(name_count),
              Max = max(name_count),
              Avg = mean(name_count) )

bnames %>% filter(name =='John') %>%  arrange(desc(name_count)) %>%  head(10)

bnames %>%  filter(name == 'John') %>% summarise(Total_John = sum(name_count) )

class(bnames)
head(bnames)

group_by(bnames, name)
head(bnames)

bnames %>% 
    group_by(name) %>%   
    summarise(Total_names = sum(name_count) ) %>% 
    arrange(desc(Total_names)) %>% 
    head(10)

bnames = group_by(bnames, name)
head(bnames)
bnames =ungroup(bnames)

bnames %>% filter(sex == 'girl') %>% 
    group_by(name) %>%   
    summarise(Total_names = sum(name_count) ) %>% 
    arrange(desc(Total_names)) %>% 
    head(10)

bnames %>% 
    filter(name == 'James') %>% 
    group_by(name, sex) %>% 
    summarise(Total = sum(name_count) ) %>% 
    ggplot( aes(sex, Total)) + geom_bar(stat='identity', aes(fill=sex))

library(reshape2)
bnames %>% 
    group_by(name, sex) %>% 
    summarise(Total = sum(name_count) ) %>% 
    dcast(name ~ sex, value.var = 'Total', na.rm = T) %>% 
    filter( !is.na(boy) & !is.na(girl)) %>% 
    mutate( diff = abs(boy-girl) ) %>% 
    filter( boy > 50000 & girl > 50000) %>% 
    arrange(diff) %>% 
    head(10)  %>% 
    melt(id=c('name','diff'), 
         variable.name = 'sex', value.name = 'count') %>% 
    mutate(NameRank = factor(name, levels=unique(name)) ) %>% 
    ggplot( aes(NameRank, count) ) + 
    geom_bar(stat = 'identity', aes(fill=sex), position = 'dodge' )



