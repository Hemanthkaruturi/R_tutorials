setwd('C:/Eminent')
library(readxl)

training.data.raw =  read.csv('titanic_train.csv',header=T,na.strings=c("")) 
View(training.data.raw)

sapply(training.data.raw,function(x) sum(is.na(x)))
sapply(training.data.raw, function(x) length(unique(x)))

library(Amelia)
missmap(training.data.raw, main = "Missing values vs observed")

data = subset(training.data.raw,select=c(2,3,5,6,7,8,10,12))
missmap(data, main = "Missing values vs observed")

data$Age[is.na(data$Age)] = mean(data$Age,na.rm=T)
View(data)

is.factor(data$Sex)
is.factor(data$Embarked)

contrasts(data$Sex)
contrasts(data$Embarked)

data = data[!is.na(data$Embarked),]
rownames(data) = NULL
dim(data)

anova(model, test="Chisq")
train = data[1:800,]
test  =  data[801:889,]

model = glm(Survived ~.,family=binomial(link='logit'),data=train)
summary(model)

install.packages('pscl')
library(pscl)
pR2(model)


fitted.results = predict(model,newdata=subset(test,select=c(2,3,4,5,6,7,8)),type='response')
fitted.results = ifelse(fitted.results > 0.5,1,0)
misClasificError = mean(fitted.results != test$Survived)
print(paste('Accuracy',1-misClasificError))


library(ROCR)
p =  predict(model, newdata=subset(test,select=c(2,3,4,5,6,7,8)), type="response")
pr = prediction(p, test$Survived)
prf = performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)

auc = performance(pr, measure = "auc")
auc = auc@y.values[[1]]
auc


