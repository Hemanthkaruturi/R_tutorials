set.seed (1)
x=matrix (rnorm (20*2) , ncol =2)
y=c(rep (-1,10) , rep (1 ,10) )
x[y==1 ,]= x[y==1,] + 1
plot(x, col =(3-y))
ggplot(dat,aes(x.2, x.1, color=y)) + geom_point()

dat=data.frame(x=x, y=as.factor (y))
View(dat) 
library (e1071)

svmfit =svm(y∼., data=dat , kernel ="linear", 
            cost =10,
            scale =FALSE )


# Visaul fit    
plot(svmfit , dat)

summary (svmfit )

# List of support vectors
svmfit$index

# Decrease the cost
svmfit =svm(y∼., data=dat , kernel ="linear", 
            cost =0.1,
            scale =FALSE )

plot(svmfit , dat)

# List of support vectors
# What happens to no.of suport vectors ?
svmfit$index

set.seed (1)
tune.out=tune(svm ,y∼.,data=dat ,
              kernel ="linear",
              ranges =list(cost=c(0.001 , 0.01, 0.1, 1,5,10,100) ))


summary (tune.out)


bestmod =tune.out$best.model
summary (bestmod )


xtest=matrix (rnorm (20*2) , ncol =2)
ytest=sample (c(-1,1) , 20, rep=TRUE)
xtest[ytest ==1 ,]= xtest[ytest ==1,] + 1
testdat =data.frame (x=xtest , y=as.factor (ytest))

ypred=predict (bestmod ,testdat )
table(predict =ypred , truth= testdat$y )

svmfit =svm(y∼., data=dat , kernel ="linear", cost =.01,
              scale =FALSE )
ypred=predict (svmfit ,testdat )
table(predict =ypred , truth= testdat$y )

# Lineraly seperable 
x[y==1 ,]= x[y==1 ,]+0.5
plot(x, col =(y+5) /2, pch =19)

dat=data.frame(x=x,y=as.factor (y))
svmfit =svm(y∼., data=dat , kernel ="linear", cost =1e5)
summary (svmfit )

plot(svmfit , dat)

svmfit =svm(y∼., data=dat , kernel ="linear", cost =1)
summary (svmfit )
plot(svmfit ,dat )
