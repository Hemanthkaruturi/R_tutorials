#install.packages('outliers')
 library(outliers)


#Missing Data

mydata = read.csv('Advertising_Missing.csv')
View(mydata)

names(mydata)

mydata$sales[1:10]
sales[1:10]
attach(mydata)
sales[1:10]

detach(mydata)

#Test is the value is NA - TRUE or FALSE
is.na(NA)
is.na(TV)
sum(is.na(TV))

#How many missing ?
sum(is.na(TV) | is.na(radio) | is.na(newspaper) | is.na(sales) )

#Which row index ?
row_x = which(is.na(TV) | is.na(radio) | is.na(newspaper) | is.na(sales) )
row_x

#What are they ?
mydata[row_x,]
mydata[is.na(TV) | is.na(radio) | is.na(newspaper) | is.na(sales),]

 sum(is.na(TV) ) *100  / length(TV)


 sapply(mydata, function(df) {sum(is.na(df) *100)/ length(df)})
# sapply(mydata, perc_na)
# 
# perc_na = function(df) {
#     sum(is.na(df) *100)/ length(df)
#     }


sapply(mydata, sum)

install.packages('Amelia')
library(Amelia)

missmap(mydata)
AmeliaView()


mydata_na = mydata
dim(mydata_na)
mydata_nona = na.omit(mydata_na)
dim(mydata_nona)
sapply(mydata_nona, function(df) {sum(is.na(df) == TRUE)/ length(df)})


mydata$TV[is.na(mydata$TV)]

#Display the rows with TV having NA
row_na_TV = which(is.na(mydata$TV))
mydata[(row_na_TV),]

#Impute Mean
mean(mydata$TV, na.rm = T)
mydata$TV[is.na(mydata$TV)] = mean(mydata$TV, na.rm = T)
mydata[(row_na_TV),]
 

dataset = read.csv('Advertising_Missing.csv')
View(dataset)

 dataset$myfactor = 0
 dataset$myfactor[1:100] = 1
 dataset$myfactor[100:200] = 2
str(dataset)

#dataset$myfactor = factor(dataset$myfactor)
#with(dataset, do.call(rbind, tapply(TV, myfactor, function(x)  c(M=mean(x, na.rm=T), SD =sd(x, na.rm=T) ) )))
 

#How many missing ?
sum(is.na(dataset$TV))
row_TV_na = which(is.na(dataset$TV) )

row_TV_na

#What are they ?
dataset[row_TV_na,]

# Taking care of missing data considering factors while imputing mean
dataset$TV = ifelse(is.na(dataset$TV),
                     ave(dataset$TV,dataset$myfactor, FUN = function(x) mean(x, na.rm = TRUE)),
                     dataset$TV)

# Taking care of missing data without factors  i.e. only one mean
dataset$TV = ifelse(is.na(dataset$TV),
                    mean(dataset$TV, na.rm = TRUE),
                    dataset$TV)

#dataset$radio =  ?

sum(is.na(dataset$radio))
row_radio_na = which(is.na(dataset$radio) )

row_radio_na

#What are they ?
dataset[row_radio_na,]

# Taking care of missing data considering factors while imputing mean
dataset$radio = ifelse(is.na(dataset$radio),
                    ave(dataset$radio, FUN = function(x) mean(x, na.rm = TRUE)),
                    dataset$radio)

    
    
# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
dataset = read.csv('Advertising.csv')
names(dataset)
dim(dataset)
library(caTools)
set.seed(456)
# using split
split = sample.split(dataset$sales, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

dim(training_set)
View(training_set)
# Using sampling 

mysample = dataset[sample(1:nrow(dataset), 60, replace = TRUE),]

nrow(dataset)
nrow(training_set)
nrow(test_set)
nrow(mysample)
    

dataset = read.csv('Grade_Scores_Tinkle.csv')
names(dataset)
View(dataset)
summary(dataset$Grade)

unique(dataset$Grade)

# Encoding categorical data
dataset$Grade = factor(dataset$Grade,
                         levels = c("Grade6", "Grade7", "Grade8"),
                         labels = c(1, 2, 3))



#Outlier treatment
set.seed(123)
y=rnorm(50)
outlier(y)
 
outlier(y,opposite=TRUE)
 
dim(y) <- c(10,5)  # convert it to a matrix
outlier(y)
 
outlier(y,opposite=TRUE)

set.seed(123)
x = rnorm(100)
scores(x)  # z-scores => (x-mean)/sd
scores(x, type="chisq")  # chi-sq scores => (x - mean(x))^2/var(x)
#> [1] 0.68458034 0.44007451 2.17210689 3.88421971 0.66539631  . . .
scores(x, type="t")  # t scores 


dataset = read.csv('Advertising_Outlier.csv')
names(dataset)


x = dataset$sales
qnt  = quantile(x, probs=c(.25, .75), na.rm = T)
caps = quantile(x, probs=c(.05, .95), na.rm = T)
H  = 1.5 * IQR(x, na.rm = T)
x[x < (qnt[1] - H)] = caps[1]
x[x > (qnt[2] + H)] = caps[2]


