# conditional statements

### IF
x = 3
if (x == 3){
  print('x is equal to 3')
}

### else

if (x>3){
  print('x is greater than 3')
}else{
  print('x is not greater than 3')
}


### else if
if (x >3){
  print('x is greater than 3')
}else if (x == 3){
  print('x is equal to 3')
}else{
  print('x is less than 3')
}

a = readline(prompt = 'Enter a value: ')
a = as.integer(a)
4|3
4 %% 3

number <- 2

#number <- as.integer(number)

if ((number%%2) == 0){
  print('Given number is even')
}else{
  print('Given number is odd')
}

x = 10
while (x > 0){
  
  x = x-1
  if (x == 3){
    next
  }
  print(x)
}

v = c(1,2,3,4)
for (i in v){
  print(i)
}

n = 3
n1 = (n%%2)+1

a <- switch(n1,'Even','Odd')
print(a)

### functions
def fun():
  print('This is a function')

fun <- function(){
  print('This is a function')
}

fun()

add <- function(){
  x = 1
  y = 2
  print(x+y)
}

add()

## arguments
add <- function(x,y){
  print(x+y)
}

add(2,3)

## return 
add <- function(x,y){
  return (x+y)
}

n <- add(4,5)
print(n)

sub <- function(x,y){
  return (x-y)
}

multi <- function(x,y){
  return (x*y)
}
n <- readline(prompt = '1.Add, 2.Sub, 3.Multi -> ')
n <- as.integer(n)
s <- switch(6,fun(),sub(4,3),multi(4,4))
s

fun <- function(){
  print('This is a function')
  print('This is another function')
}

v <- c(1,2,-3,4)

c = 0
for (i in v){
  c = c+1
  if (i < 0){
    v[c] = 0
  }else{
    print(i)
  }
    
}

v

v <- c(1,2,3,4)
v[4]
v[5] = 6


name = 'Eminent'
print(paste('Hi',name))




