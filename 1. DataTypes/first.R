print('Hello R')

x <- 1
y <- 2
z <- x+y
print(z)

## datatypes
x <- 1
typeof(x)
typeof(y)
typeof(z)

x <- 2L
typeof(x)

a <- 4
typeof(a)

x <- as.integer(a)

rm(x)
rm(y)

a = 1L
b = 2L
c = a+b

a = 1
a = 2.2
b = as.integer(a)

a = TRUE
b = FALSE

a = as.integer(a)
b = as.integer(b)
a = 1
typeof(a)
typeof(b)
class(a)
class(c)

s <- 'Eminent'
typeof(s)

substr(s,1,3)

s <- '1,2,3,4'
strsplit(s,',')
str

v <- c(1,2,3,4)
v[1]
v[2]
v[3]
v[4]

v <- c(1,2,3,4L)
v
v[1]
typeof(v[4])

v <- c(1,2,3,'Eminent')
v[1]
typeof(v)
typeof(v[1])

v1 = c(1,2,3,4)
typeof(v1)
class(v1)

v2 <- c(1L,2L,3L,4L)
typeof(v2)
typeof(v2[1])

v3 <- c(a=1,b=2,c=3,d=4)
names(v3)
v3
v3[1]

a = 3

v3[1:3]

v3 <- c(a=1,b=2,c=3,4)
v3

v4 <- c(4,5,6,7)
names(v4) <- c('a','b','c','d')
v4
sum(v4)
min(v4)
max(v4)
length(v4)
mean(v4)

m <- matrix(c(1:16), nrow = 4,ncol = 4, byrow = TRUE, dimnames = list(c('F','S','T','F'),c('col1','col2','col3','col4')))
m[,'col1']
m[4,]
m['T',]
m[c('S','T'),c('col3','col4')]
m[1]
m[2]
m[16]


m[c(2,3),c(2,3)]

m[c(3,4),c(3,4)]

m[c(2,3),c(1,4)]

m[,1]
m[1,]

m[,2:3]
m[,c(2,3)]

m[,c(1,4)]

m[2,3]

l = list(a=1,b=2,c=3,d=4)
typeof(l$a)
l$b
l$c

l[1]
l[2]

l1 = list(1L,2.4,'Eminent',TRUE)
l1

l2 = list(c(1,2,3,4),c(5,6,7,8))

l2[[1]][4]

l1[[1]]
l1[[1]]

l1[1:3]

typeof(l1)
typeof(l1[[1]])
typeof(l1[2])

typeof(m)
class(m)
