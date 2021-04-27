setwd('C:/Eminent')

perfdata = read.csv('Student_Perf.csv')
dim(perfdata)
View(perfdata)
names(perfdata)

names(perfdata)[33]
names(perfdata)[33] = 'final_score'

perfdata = perfdata[,c('age','address','studytime','famsup','schoolsup','absences','paid','final_score')]


set.seed(123) 
index = sample(1:3,nrow(perfdata), replace=T)
summary(as.factor(index))

index = sample(1:3,nrow(perfdata), replace=T, prob = c(.75, .15, .1) )
summary(as.factor(index))

train = perfdata[index == 1, ]
valid = perfdata[index == 2, ]
test  = perfdata[index == 3, ]

dim(train)


score_model = rpart(final_score ~ .,
                    data = train,
                    method = 'anova',
                    control = rpart.control(maxdepth = 4)
                    )

print(score_model)
rpart.plot(score_model)

pred_test = predict(score_model, 
                    newdata = test)

library(Metrics)
rmse(actual = test$final_score,
     predicted = pred_test)

plotcp(score_model)
print(score_model$cptable)


score_model_optimal = prune(score_model, cp=0.02345820 )
rpart.plot(score_model_optimal)

pred_test_optimal = predict(score_model_optimal, 
                    newdata = test)

rmse(actual = test$final_score,
     predicted = pred_test_optimal)
