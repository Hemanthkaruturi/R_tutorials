# import data from csv
data_csv = read.csv('C:\\Users\\600037209\\Documents\\Classes\\Data\\Death rates and life expectancy\\NCHS_-_Death_rates_and_life_expectancy_at_birth.csv')
data_csv = read.csv(file.choose())
typeof(data_csv)
class(data_csv)
summary(data_csv)

# import data from excel
library(readxl)
data_excel = read_excel('C:\\Users\\600037209\\Documents\\Classes\\Data\\Death rates and life expectancy\\NCHS_-_Death_rates_and_life_expectancy_at_birth.xlsx')

# import data from json
library(rjson)
json_data = fromJSON(file='C:\\Users\\600037209\\Documents\\Classes\\Data\\Death rates and life expectancy\\NCHS_-_Death_rates_and_life_expectancy_at_birth.json')
names(json_data)
typeof(json_data)

year = c()
race = c()
sex = c()
ALE = c()
mortality = c()
for (i in 1:length(json_data$data)){
  #print(json_data$data[[i]][[9]])
  year[i] <- json_data$data[[i]][[9]]
  race[i] <- json_data$data[[i]][[10]]
  sex[i] <- json_data$data[[i]][[11]]
  result <- tryCatch({
    ALE[i] <- json_data$data[[i]][[12]]
  }, error = function(e){
    print('value is null')
  })
  
  mortality[i] <- json_data$data[[i]][[13]]
  
}

data_json <- data.frame(year,race,sex,ALE,mortality)

# import xml data
library(XML)
xml_data <- xmlParse(file='C:\\Users\\600037209\\Documents\\Classes\\Data\\Death rates and life expectancy\\NCHS_-_Death_rates_and_life_expectancy_at_birth.xml')
xml_data_list <- xmlToList(xml_data)
xml_data_list$row[2]$row

year = c()
race = c()
sex = c()
ALE = c()
mortality = c()
for (i in 1:length(xml_data_list$row)){
  year[i] = xml_data_list$row[i]$row$year
  race[i] = xml_data_list$row[i]$row$race
  sex[i] = xml_data_list$row[i]$row$sex
  result <- tryCatch({
    ALE[i] = xml_data_list$row[i]$row$average_life_expectancy
  }, error = function(e){
    print('Null value')
  })
  
  mortality = xml_data_list$row[i]$row$mortality
}

data_xml <- data.frame(year,race,sex,ALE,mortality)
names(data_xml)
str(data_xml)
str(data_json)

## import data from database
library(odbc)
library(sqldf)

con <- dbConnect(odbc(),
                 DRIVER = 'SQL Server',
                 Server='HWAS0032.lux.intra.lighting.com',
                 database='Advance_Analytics')

query <- 'select * from All_Campaigns_to_process'
data_sql <- dbGetQuery(con,query)

dbSendQuery(con, query)





