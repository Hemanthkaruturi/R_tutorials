#list
l <- list(1,2,3,4)
l[1:3]
l[2]
l[3]

#slicing lists
l1 <- list(1,1.2,'Hemanth',list(2,3,4,5))
typeof(l[[1]])
class(l[[1]])
l[1]

typeof(l1[[3]])

l1[[4]][[1]]

l1[1:4]

l1 <- list(1,2,3,4)

#Range in list is different from Python range
range(1,2,3,4,5)
list(1:5)

#For printing sequence of values which acts like Range in python
seq(5)

#removing variabbles or objects
rm(l)
rm(l1)

rm(str,str1,x,y,z)

## Vectors
x <- c(1,2,3,4)
typeof(x)
class(x)

x[1]
x[2]

x <- c('Hemanth','Mahesh','Abhi')
class(x)
x[1]


x <- c(1,2,3,'Nithin')
x
class(x)

v <- c(1,2,3)
v1 <- c(3,2,5)

#vector manipulation
v + v1
v/v1
v - v1
v[1] <- 4
v

qx1 <- c('Ravi','Nitesh')
x + x1

#Arrays
arr <- array(c(1,2,3,4))
arr

vec <- c(23,25,32)
vec1 <- c(22,20,32)

arr <- array(vec)
arr1 <- array(vec1)

arr + arr1

arr_list <- array(list(1,2,3,4))
arr_list1 <- array(list(2,2,3,4))

arr_list + arr_list1

class(arr)
class(arr_list)

#multi dimensional arrays
arr <- array(c(1,2,3,4))
arr1 <- array(c(1,2,3,4,5,6,7,8,9,10,11,12), dim = c(4,3))
arr1
arr1[2:4,2:3]

#Matices
mat <- matrix(c(1,2,3,4,5,6,7,8,9,10,11,12), nrow=4, ncol = 3)
mat

Emp_id <- c(234,212,276,284)
Emp_name <- c('Hemanth','John','Pradeep','Adarsh')
Emp_Age <- c(23,26,27,24)

emp_mat <- matrix(c(Emp_id,Emp_name,Emp_Age), nrow=4, ncol=3)
colnames(emp_mat) <- c("Emp_id","Emp_name","Emp_Age")
emp_mat[1:8]

mdat <- matrix(c(1,2,3, 11,12,13), nrow = 2, ncol = 3, byrow = TRUE,
               dimnames = list(c("row1", "row2"),
                               c("C.1", "C.2", "C.3")))

#dataframes
emp_dat <- data.frame(Emp_id,Emp_name,Emp_Age, stringsAsFactors = FALSE)
emp_dat
View(emp_dat)
str(emp_dat)
levels(emp_dat$Emp_name)

#Factors
city <- c("Bengaluru","Bengaluru","Chennai","Mumbai","Kolkata","Chennai")
city
city <-  as.factor(city)
levels(city)

typeof(emp_dat['Emp_name'])
class(emp_dat['Emp_name'])

emp_dat[c('Emp_id','Emp_name')]

#slicing dataframes
emp_dat[c(2:4),]
emp_dat[c(2:4),c(2:3)]

emp_dat[,c(2:3)]

emp_dat[emp_dat['Emp_Age'] > 25,]

max(arr)
min(arr)
sum(arr)

abs(arr)
