
slrdata = read.csv('Salary_Data_2.csv')

View(slrdata)
names(slrdata)



names(slrdata) = c('salary','age','gender')
class(slrdata$gender)
View(slrdata)
str(slrdata)

slrdata$gender = factor(slrdata$gender)
 
                        

ggplot(slrdata,aes(x=age, y =salary)) + geom_point() 
ggplot(slrdata,aes(x=age, y =salary, color = gender)) + geom_point() 


slrLM = lm(salary ~ age  , data=slrdata)
summary(slrLM)
coef(slrLM)
#(Intercept)         age
#0.429             0.273 

slrdata$gender = factor(slrdata$gender)
ggplot(slrdata,aes(x=age, y =salary, color = gender)) + geom_point() +
    geom_abline(aes(intercept=0.429 , slope=0.273))


 

slrLM = lm(salary ~ age + gender, data=slrdata)
summary(slrLM)


coef(slrLM)

#(Intercept)         age      gender1 
#   0.5351          0.1791    0.4123 

# salary = 0.5351 +  (0.1791)*age + (0.4123)*gender1

# for male (gender=1)
# salary = 0.5351 +  (0.1791)*age + (0.4123)*gender1
# salary = 0.947  +  (0.1791)*age
#

# what happenes when gener is female (0) ?

# salary = 0.5351 +  (0.1791)*age  

# slrtidy = melt(slrdata, id =c('salary'))
# View(slrtidy)
# str(slrdata)

slrdata$gender = factor(slrdata$gender)
 
ggplot(slrdata,aes(x=age, y =salary, color=gender)) + 
    geom_point() 
 
# slrLM.reg = data.frame(t(coef(slrLM)))
# names(slrLM.reg)

#names(slrLM.reg) = c('intercept','slope_age','slope_gender')

ggplot(slrdata,aes(x=age, y =salary, color=gender)) + 
    geom_point() +
    geom_abline(aes(intercept=0.947, slope=0.1791)) +
    geom_abline(aes(intercept=0.5351, slope=0.1791))
