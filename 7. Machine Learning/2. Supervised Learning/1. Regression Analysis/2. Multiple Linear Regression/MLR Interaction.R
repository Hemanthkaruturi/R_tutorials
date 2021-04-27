

stdata  = read.csv('Stock Price.csv')
View(stdata)
names(stdata)

names(stdata) = c('stk1','stk2', 'stk3')

stk1lm = lm(stk1 ~ stk2 + stk3, data=stdata)
summary(stk1lm)


stk1lm_int = lm(stk1 ~ stk2 + stk3 + stk2:stk3, data=stdata)
summary(stk1lm_int)

AIC(stk1lm)
AIC(stk1lm_int)
