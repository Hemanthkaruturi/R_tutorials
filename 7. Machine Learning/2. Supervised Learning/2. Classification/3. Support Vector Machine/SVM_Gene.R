library (ISLR)
data(Khan)
names(Khan)

dim( Khan$xtrain )
class(Khan)
dim( Khan$xtrain)
dim( Khan$xtest )
lapply(Khan,class)
lapply(Khan,dim)
lapply(Khan,length)

table(Khan$ytrain)
table(Khan$ytest)

dat=data.frame(x=Khan$xtrain , y=as.factor ( Khan$ytrain ))
out=svm(y~., data=dat , kernel ='linear',cost =10)
summary (out)
table(out$fitted , dat$y)


dat.test=data.frame(x=Khan$xtest , y=as.factor (Khan$ytest ))
pred.test=predict(out , newdata =dat.test)
table(pred.test , dat.test$y)

dat=data.frame(x=Khan$xtrain , y=as.factor ( Khan$ytrain ))
out=svm(y~., data=dat , kernel ='radial',cost =10)
summary (out)


table(out$fitted , dat$y)


dat.test=data.frame(x=Khan$xtest , y=as.factor (Khan$ytest ))
pred.test=predict(out , newdata =dat.test)
table(pred.test , dat.test$y)
