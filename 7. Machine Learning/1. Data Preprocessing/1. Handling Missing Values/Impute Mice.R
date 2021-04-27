#Missing Data
setwd('C:/Users/600037209/Documents/Classes/Data')

mydata = read.csv('Advertising_Missing.csv')

names(mydata)
attach(mydata)

#Test is the value is NA - TRUE or FALSE
is.na(NA)

#missing values in each column
colSums(is.na(mydata))

#How many missing ?
sum(is.na(TV) | is.na(radio) | is.na(newspaper) | is.na(sales) )

#Which row index ?
row_x = which(is.na(TV) | is.na(radio) | is.na(newspaper) | is.na(sales) )
row_x

#What are they ?
mydata[row_x,]
mydata[is.na(TV) | is.na(radio) | is.na(newspaper) | is.na(sales),]

sapply(mydata, function(df) {sum(is.na(df) == TRUE)/ length(df)})

install.packages('Amelia')
library(Amelia)
missmap(mydata)
AmeliaView()


mydata_na = mydata
dim(mydata_na)
mydata_nona = na.omit(mydata_na)
dim(mydata_nona)
sapply(mydata_nona, function(df) {sum(is.na(df) == TRUE)/ length(df)})


mydata_na$TV[is.na(TV)]
row_na_TV = which(is.na(mydata_na$TV))
mydata_na[(row_na_TV),]

mean(mydata_na$TV, na.rm = T)
mydata_na$TV[is.na(TV)] = mean(mydata_na$TV, na.rm = T)
mydata_na[(row_na_TV),]


### homework... impute mean value to radio newspaper sales

dataset = read.csv('Advertising_Missing.csv')

#How many missing ?
sum(is.na(dataset$TV))
row_TV_na = which(is.na(dataset$TV) )
row_TV_na

#What are they ?
dataset[row_TV_na,]

# Taking care of missing data
dataset$TV = ifelse(is.na(dataset$TV),
                     ave(dataset$TV, FUN = function(x) mean(x, na.rm = TRUE)),
                     dataset$TV)

dataset$radio =  ?

#visualizing missing values
library(VIM)
names(dataset)

mice_plot <- aggr(dataset, col=c('navyblue','yellow'),
                  numbers=TRUE, sortVars=TRUE,
                  labels=names(dataset), cex.axis=.7,
                  gap=3, ylab=c("Missing data","Pattern"))    

    
mice_plot <- aggr(mydata, col=c('navyblue','yellow'),
                  numbers=TRUE, sortVars=TRUE,
                  labels=names(mydata), cex.axis=.7,
                  gap=3, ylab=c("Missing data","Pattern"))   

#Other packages for imputing missing values
#install.packages("Amelia")
library(Amelia)
names(mydata)
mydata <- mydata[2:5]
amelia_fit <- amelia(mydata, m=5, parallel = "multicore")

mydata_amelia_imputed <- amelia_fit$imputations[[1]] 
mydata_amelia_imputed1 <- amelia_fit$imputations[[2]]
mydata_amelia_imputed2 <- amelia_fit$imputations[[3]]

colSums(is.na(mydata_amelia_imputed))

#using missForest
install.packages("missForest")
library(missForest)

mydata.imp <- missForest(mydata)

mydata_missForest_imputed <- mydata.imp$ximp
colSums(is.na(mydata_missForest_imputed))

mydata.imp$OOBerror
