library(ggplot2)

cbdata = read.csv('Cibil.csv')
View(cbdata)
names(cbdata) = c('score','approval')
cbdata$approval = factor(cbdata$approval)

ggplot(cbdata, aes(x=score, y = approval, color=approval)) + geom_point()

cbdata$approval = as.numeric(cbdata$approval)
mymodel = lm(approval ~ score, data=cbdata)

summary(mymodel)
coef(mymodel)


ggplot(cbdata, aes(x=score, y= approval, color=approval)) + 
    geom_point() +
    geom_abline(aes(intercept = 0.313678461, slope = 0.00185))



vsdata = read.csv('Resort_Visit.csv')
View(vsdata)

names(vsdata)

names(vsdata) = c('visit','income','attitude','imp','size','age')
vsdata$visit = factor(vsdata$visit)

visit   = vsdata$visit
income  = vsdata$income
attitude= vsdata$attitude
imp     = vsdata$imp
size    = vsdata$size
age     = vsdata$age


str(visit)
# Covert the respose variable to discrete
visit = factor(visit)
str(visit)


ggplot(vsdata,aes(x=income, y=visit, color=visit)) + geom_point()
ggplot(vsdata,aes(x=age, y=visit, color=visit)) + geom_point()
ggplot(vsdata,aes(x=attitude, y=visit, color=visit)) + geom_point()
ggplot(vsdata,aes(x=imp, y=visit, color=visit)) + geom_point()
ggplot(vsdata,aes(x=size, y=visit, color=visit)) + geom_point()



# cgecking the correltion - Xs should not be highly correlated
cor(vsdata)
M = cor(vsdata)
head(round(M,2))

corrplot(M, method = 'circle')


# Checking relation between Xs and Y
aggregate(income ~visit, FUN = mean)
aggregate(attitude ~visit, FUN = mean)
aggregate(imp ~visit, FUN = mean)
aggregate(size ~visit, FUN = mean)
aggregate(age ~ visit, FUN = mean)


aggregate(income ~visit, FUN = mean) %>% 
    ggplot(aes(x = visit, y = income, fill=visit)) +
    geom_bar(stat="identity") 


rb1 = aggregate(income ~visit, FUN = mean)
rb1$input = 'income'
names(rb1) = c('visit','avg','input')

rb2 = aggregate(attitude ~visit, FUN = mean)
rb2$input = 'attitude'
names(rb2) = c('visit','avg','input')

rb3 = aggregate(imp ~visit, FUN = mean)
rb3$input = 'imp'
names(rb3) = c('visit','avg','input')

rb4 = aggregate(size ~visit, FUN = mean)
rb4$input = 'size'
names(rb4) = c('visit','avg','input')

rb5 = aggregate(age ~ visit, FUN = mean)
rb5$input = 'age'
names(rb5) = c('visit','avg','input')

 
myplotdf = rbind(rb1,rb2,rb3,rb4,rb5)
View(myplotdf)

myplotdf2 = myplotdf[ , c('visit','input','avg')]
View(myplotdf2)

#Higher the difference in means, stronger will be the relation to response variable

#Table display
dcast(myplotdf2, visit ~ input, var.value='avg')

# Graphical display 
ggplot(myplotdf, aes(x = visit, y = avg, fill=visit)) +
    geom_bar(stat="identity") +
    facet_wrap(~input, ncol=5, scales='free') +
    scale_fill_brewer(palette = "Reds")

# to list the avilable palettes   
#RColorBrewer::display.brewer.all()

# checking the diff
boxplot(income ~ visit)
boxplot(income ~ visit)
boxplot(attitude ~ visit)
boxplot(imp ~ visit)
boxplot(size ~ visit)
boxplot(age ~ visit)


# Build the model

model = glm(visit ~ income + attitude + imp  + size + age, family = binomial(logit))
summary(model)


anova(model,test = 'Chisq')
summary(model)


