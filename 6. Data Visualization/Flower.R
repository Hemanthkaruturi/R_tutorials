# This sets plot images to a nice size.
options(repr.plot.width = 4, repr.plot.height = 4)

# Loading in the ggplot2 package
# .... YOUR CODE FOR TASK 1 ....
library(ggplot2)

t = seq(0, 2*pi, length.out = 50)
x = sin(t)
y = cos(t)
df = data.frame(t, x, y)

# Make a scatter plot of points in a circle
p = ggplot(df, aes(x, y))
# .... YOUR CODE FOR TASK 2 .... 
p + geom_point()


# Defining the number of points
# .... YOUR CODE FOR TASK 3 ....
points = 500

# Defining the Golden Angle
# .... YOUR CODE FOR TASK 3 ....
angle = pi*(3-sqrt(5)) 
    
t = (1:points) * angle
x = sin(t)
y =cos(t)
df = data.frame(t, x, y)

# Make a scatter plot of points in a spiral
p = ggplot(df, aes(x*t, y*t))
#p + # .... YOUR CODE FOR TASK 3 ....
p + geom_point() +
# .... YOUR CODE FOR TASK 4 ....
    theme(panel.background = element_blank(),
          panel.grid = element_blank(),
          axis.text =  element_blank(),
          axis.title = element_blank())

# Task 5
p + geom_point(size = 8, alpha = 0.5, color = 'darkgreen') +
    # .... YOUR CODE FOR TASK 4 ....
    theme(panel.background = element_blank(),
          panel.grid = element_blank(),
          axis.text =  element_blank(),
          axis.title = element_blank())

# Task 6
p + geom_point(size = t, alpha = 0.5, color = 'black', shape=8) +
    # .... YOUR CODE FOR TASK 4 ....
    theme(panel.background = element_blank(),
          panel.grid = element_blank(),
          axis.text =  element_blank(),
          axis.title = element_blank())

# Task 7
p + geom_point(size = t, alpha = 0.5, color = 'yellow', shape=17) +
    theme(panel.background = element_rect(fill = 'darkmagenta'),
          panel.grid = element_blank(),
          axis.text =  element_blank(),
          axis.title = element_blank())

# Task 8
#angle = pi*(3-sqrt(5))
angle = 2.0
points = 1000

t = (1:points)*angle
x = sin(t)
y = cos(t)

df = data.frame(t, x, y)

p = ggplot(df, aes(x*t, y*t))
p + geom_point(size = t, alpha = 0.1, color = 'yellow', shape=8) +
    theme(panel.background = element_blank(),
          panel.grid = element_blank(),
          axis.text =  element_blank(),
          axis.title = element_blank())


# Task 9
#angle = pi*(3-sqrt(5))
angle = 13*pi/180
points = 2000

t  = (1:points)*angle
x  = sin(t)
y  = cos(t)

df = data.frame(t, x, y)

p = ggplot(df, aes(x*t, y*t))

j = 20
 
p + geom_point(size = 85, alpha = 0.1, color = 'magenta4', shape=1) +
    theme(panel.background = element_blank(),
          panel.grid = element_blank(),
          axis.text =  element_blank(),
          axis.title = element_blank())
 
