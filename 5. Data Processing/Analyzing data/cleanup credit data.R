library(dplyr)

setwd('C:/Eminent')
loandata = read.csv('LoanStats3a.csv', na.strings = c('.','') )
View(loandata)
dim(loandata)
str(loandata)

result_na = sapply(loandata, function(df) {sum(is.na(df) *100)/ length(df)}) 
result_na = round(result_na, digits = 2)
class(result_na)

result_na_df = as.data.frame(result_na)
View(result_na_df)

result_na_df$column = row.names(result_na_df)
row.names(result_na_df) = NULL
    
result_na_df = result_na_df[ , c("column", "result_na")]
str(result_na_df)    

result_na_df = result_na_df %>% arrange( desc(result_na_df$result_na) )
View(result_na_df)
result_na_df = result_na_df[result_na_df$result_na < 5,]
View(result_na_df)
 
loandata = loandata[ , result_na_df$column]
dim(loandata)
View(loandata)



table(loandata$id)
length(loandata$id[2])
loandata$id[2]

unique(loandata$pub_rec_bankruptcies)
table(loandata$pub_rec_bankruptcies)
table(loandata$loan_status)
