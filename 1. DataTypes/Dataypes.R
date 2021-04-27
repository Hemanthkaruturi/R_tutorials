#Numeric values
x <- 1
typeof(x)
class(x) 

y <- 1.2
typeof(y)
class(y)

#type casting
as.integer(y)

#characters
z <- 'Hemanth'
class(z)
typeof(z)

z <- 'Welcome \string'
z <- 'Welcome \ string'
z <- 'welcome \n string'
z <- 'welcome \s string'

#character functions
toupper(z)
tolower(z)

#Replace characters
str <- 'Welcome to R programming'
gsub('programming','scripting',str)

str1 <- 'It is very interesting'

#Adding/concatinating 2 strings 
typeof(paste(str,str1, sep = ", "))
typeof(cat(str,str1))

#Splitting string to list
substr(str,1,7)
strsplit(str,split="[[:space:]]")
strsplit(str,split="[[:space:]]")[[1]]
strsplit(str,split="[[:space:]]")[[1]][2]

#Boolean
TRUE
FALSE