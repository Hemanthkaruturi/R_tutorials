# Data Preprocessing
setwd('C:/Users/600037209/Documents/Classes/Data')

# Importing the dataset
dataset = read.csv('Data.csv')

is.na(dataset$Age)

colSums(is.na(dataset))

# Taking care of missing data
dataset$Age = ifelse(is.na(dataset$Age),
                     ave(dataset$Age, FUN = function(x) mean(x, na.rm = TRUE)),
                     dataset$Age)
dataset$Salary = ifelse(is.na(dataset$Salary),
                        ave(dataset$Salary, FUN = function(x) mean(x, na.rm = TRUE)),
                        dataset$Salary)

#
