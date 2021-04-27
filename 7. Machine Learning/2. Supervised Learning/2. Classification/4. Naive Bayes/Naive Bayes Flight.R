setwd('C:/Eminent')
fldata = read.csv('FlightDelays.csv')
View(fldata)
dim(fldata)

names(fldata)

names(fldata) = c( "CRS_DEP_TIME","CARRIER","DEP_TIME","DEST","DISTANCE","FL_DATE",
                   "FL_NUM","ORIGIN","Weather","DAY_WEEK","DAY_OF_MONTH","TAIL_NUM",      
                   "Flight_Status" )

str(fldata)
fldata$Weather  = factor(fldata$Weather)
fldata$DAY_WEEK = factor(fldata$DAY_WEEK)

summary(fldata)
fldata$DEP_TM_BIN = 'BINS' 
for (i in 1:nrow(fldata) ) {
    
    #if (fldata$CRS_DEP_TIME[i] >= 600  &  fldata$CRS_DEP_TIME[i] <= 659) { fldata$DEP_TM_BIN[i] = '0600-0659' }
    if (fldata$CRS_DEP_TIME[i] >= 700  &  fldata$CRS_DEP_TIME[i] <= 759) { fldata$DEP_TM_BIN[i] = '0700-0759' }
    if (fldata$CRS_DEP_TIME[i] >= 800  &  fldata$CRS_DEP_TIME[i] <= 859) { fldata$DEP_TM_BIN[i] = '0800-0859' }
    if (fldata$CRS_DEP_TIME[i] >= 900  &  fldata$CRS_DEP_TIME[i] <= 959) { fldata$DEP_TM_BIN[i] = '0900-0959' }
    if (fldata$CRS_DEP_TIME[i] >= 1000 &  fldata$CRS_DEP_TIME[i] <= 1059){ fldata$DEP_TM_BIN[i] = '1000-1059' }
    if (fldata$CRS_DEP_TIME[i] >= 1100 &  fldata$CRS_DEP_TIME[i] <= 1159){ fldata$DEP_TM_BIN[i] = '1100-1159' }
    if (fldata$CRS_DEP_TIME[i] >= 1200 &  fldata$CRS_DEP_TIME[i] <= 1259){ fldata$DEP_TM_BIN[i] = '1200-1259' }
    if (fldata$CRS_DEP_TIME[i] >= 1300 &  fldata$CRS_DEP_TIME[i] <= 1359){ fldata$DEP_TM_BIN[i] = '1300-1359' }
    if (fldata$CRS_DEP_TIME[i] >= 1400 &  fldata$CRS_DEP_TIME[i] <= 1459){ fldata$DEP_TM_BIN[i] = '1400-1459' }
    if (fldata$CRS_DEP_TIME[i] >= 1500 &  fldata$CRS_DEP_TIME[i] <= 1559){ fldata$DEP_TM_BIN[i] = '1500-1559' }
    if (fldata$CRS_DEP_TIME[i] >= 1600 &  fldata$CRS_DEP_TIME[i] <= 1659){ fldata$DEP_TM_BIN[i] = '1600-1659' }
    if (fldata$CRS_DEP_TIME[i] >= 1700 &  fldata$CRS_DEP_TIME[i] <= 1759){ fldata$DEP_TM_BIN[i] = '1700-1759' }
    if (fldata$CRS_DEP_TIME[i] >= 1800 &  fldata$CRS_DEP_TIME[i] <= 1859){ fldata$DEP_TM_BIN[i] = '1800-1859' }
    if (fldata$CRS_DEP_TIME[i] >= 1900 &  fldata$CRS_DEP_TIME[i] <= 1959){ fldata$DEP_TM_BIN[i] = '1900-1959' }
    if (fldata$CRS_DEP_TIME[i] >= 2000 &  fldata$CRS_DEP_TIME[i] <= 2059){ fldata$DEP_TM_BIN[i] = '2000-2059' }
    if (fldata$CRS_DEP_TIME[i] >= 2100 &  fldata$CRS_DEP_TIME[i] <= 2159){ fldata$DEP_TM_BIN[i] = '2100-2159' }
    if (fldata$CRS_DEP_TIME[i] >= 2200 &  fldata$CRS_DEP_TIME[i] <= 2259){ fldata$DEP_TM_BIN[i] = '2200-2259' }
    
}

fldata$DEP_TM_BIN = factor(fldata$DEP_TM_BIN)
unique(fldata$DEP_TM_BIN)

 
fldata$DEP_TM_CUT = cut(fldata$DEP_TIME, seq(600,2200, by = 200) , dig.lab = 4 )
#fldata$DEP_TM_CUT4 = cut(fldata$DEP_TIME, seq(600,2200, by = 400) )
unique(fldata$DEP_TM_CUT)
View(fldata)
#, dig.lab=4 

#ftable(fldata$DAY_WEEK, fldata$CARRIER, fldata$DEP_TM_CUT)
# 
# View(fldata)
library(ggplot2)
library(dplyr)
library(sqldf)
sqldf('select DEP_TM_CUT , count(*) from fldata  group by DEP_TM_CUT') 
sqldf('select Flight_Status, count(*) from fldata group by Flight_Status') 

sqldf('select Weather, count(*) from fldata group by Weather')
sqldf('select CARRIER, Flight_Status, count(*) from fldata group by CARRIER, Flight_Status')


sqldf('select Flight_Status, count(*) as Total from fldata group by Flight_Status') %>%
    ggplot(aes(Flight_Status)) + geom_bar(aes(weight = Total, fill = Flight_Status))
#    ggplot(aes(Flight_Status, Total, color=Flight_Status)) + geom_col()

sqldf('select CARRIER, Flight_Status, count(*) as Total from fldata group by CARRIER, Flight_Status') %>% 
    ggplot(aes(Flight_Status)) + geom_bar(aes(weight = Total, fill = Flight_Status)) +
    facet_wrap(.~ CARRIER, ncol = 3)
    



names(fldata)

fldata_nb = fldata[, c("CARRIER","DEST","ORIGIN","Weather","DAY_WEEK","DEP_TM_CUT","Flight_Status") ]
str(fldata_nb)


library(caTools)
set.seed(123)
# using split
split = sample.split(fldata_nb$Flight_Status, SplitRatio = 2/3)
training_set = subset(fldata_nb, split == TRUE)
test_set = subset(fldata_nb, split == FALSE)

dim(training_set)



sqldf('select Flight_Status, count(*) from training_set group by Flight_Status')
sqldf('select Weather, count(*) from training_set group by Weather')
sqldf('select Flight_Status, count(*) from test_set group by Flight_Status')
sqldf('select Weather, count(*) from test_set group by Weather')

library(e1071)


#Develop Model
model = naiveBayes(training_set[,1:6], training_set[,7])
model

summary(training_set[,7])
#1182/(1182+285)
 
#Compute Predicted values
pred_train = predict(model, training_set[,1:6])
pred_train


pred_test = predict(model, test_set[,1:6])
pred_test
summary(test_set[,7])

# Model evaluation (Actual Vs Predicted)

cm_train = table( training_set[,7],pred_train)
cm_train

cm_test = table( test_set[,7],pred_test)
cm_test

library(caret)
confusionMatrix(training_set[,7],pred_train)
confusionMatrix(test_set[,7],pred_test)
?naiveBayes
