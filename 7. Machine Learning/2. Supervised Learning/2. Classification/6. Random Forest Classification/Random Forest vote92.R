install.packages('pscl')
library(pscl)
library(caret)
library(ggplot2)
library(dplyr)

?vote92
str(vote92)
dim(vote92)
sapply(vote92,class)

table(vote92$female, vote92$vote)
table(vote92$rep, vote92$vote)
df = as.data.frame(table(vote92$rep, vote92$vote))
 
df

plot_table = function(a,b) {
    as.data.frame(table(a,b)) %>% 
        ggplot(aes(x = a, y= Freq, fill= b))+
          geom_bar(stat = 'identity')
}
 
plot_table(vote92$female, vote92$vote)
plot_table(vote92$rep, vote92$vote)
plot_table(vote92$dem, vote92$vote)
plot_table(vote92$persfinance, vote92$vote)
plot_table(vote92$natlecon, vote92$vote)

summary(vote92[,c('clintondis','bushdis','perotdis')] )

vote92$clinton_segment = cut(vote92$clintondis, seq(0,20, by = 5) )
vote92$bush_segment = cut(vote92$bushdis, seq(0,20, by = 5) )
vote92$perot_segment = cut(vote92$perotdis, seq(0,20, by = 5) )

plot_table(vote92$clinton_segment, vote92$vote)
plot_table(vote92$bush_segment, vote92$vote)
plot_table(vote92$perot_segment, vote92$vote)


dim(vote92)
summary(vote92$vote) 

# Vote classification distribution in entire dataset
round(summary(vote92$vote)*100 / nrow(vote92),2)

# Stratified splitting 
index = createDataPartition(vote92$vote, p = .7, list = F)

class(index)
dim(index)
summary(vote92[index, 'vote']) 

# Vote classification distribution in train partition 
round(summary(vote92[index, 'vote'])*100 / length(index) ,2)

# Vote classification distribution in test partition 
round(summary(vote92[-index, 'vote'])*100 / (nrow(vote92) - length(index)) ,2)


source('C:/Eminent/RF factor vote92.R')

df = get_vote_df()

 
index = createDataPartition(df$vote, p = .7, list = F)

train = df[index,]
test  = df[-index,]

trctl = trainControl(method = 'cv',
                     number = 10,
                     savePredictions = T)

tg = data.frame(mtry = 3)

model = train(vote ~. ,
              data = train,
              method = "rf",
              tuneGrid = tg,
              trControl = trctl)

test$pred = predict(model, test)

confusionMatrix(test$pred, test$vote)


mymodel = randomForest( vote ~ ., # Formula
                        data = train,          # Use training data
                        ntree = 5,             # No.of Trees
                        mtry  = 3,              # Subset of features to consider while splitting the node
                        do.trace   = T       # Print on console while training 
)
mymodel
