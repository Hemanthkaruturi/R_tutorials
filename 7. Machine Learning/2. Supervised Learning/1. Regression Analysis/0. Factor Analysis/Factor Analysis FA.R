setwd('C:/Eminent')
library(psych)
pastedata = read.csv('Toothpaste.csv')

View(pastedata)
names(pastedata)
names(pastedata) = c("V1","V2","V3","V4","V5","V6")

efa = fa(pastedata)
fa.diagram(efa)
efa$loadings
