
pkdata = read.csv('Pokemon.csv')
dim(pkdata)
View(pkdata)

names(pkdata)

pkdata = pkdata[ , c("HitPoints" ,     "Attack" ,        "Defense"   ,    
                      "SpecialAttack" , "SpecialDefense", "Speed" ) ]  

dim(pkdata)
class(pkdata)
pkdata = as.matrix(pkdata)
View(pkdata)
wss = 0

for( i in 1:15) {
    
    km.out = kmeans(pkdata, centers = i, nstart = 20)
    
    wss[i] = km.out$tot.withinss
    
}

wss

plot(1:15, wss, type = 'b')
?cutree
