#In Python
def fun():
  print('I am in a Function')


# In R
fun <- function(){
  print('I am in a Function')
}

fun()

sum <- function(a,b){
  print(a+b)
}

sum(3,7)

#function with return and default values
sum <- function(a = 0,b = 0){
  return (a+b)
}

sum_val <- sum(3,7)
sum_val


