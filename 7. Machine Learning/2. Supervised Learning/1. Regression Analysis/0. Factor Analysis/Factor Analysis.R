pastedata = read.csv('Toothpaste.csv')


View(pastedata)
names(pastedata)
names(pastedata) = c("V1","V2","V3","V4","V5","V6")

#1. Normalize the data or Transforming the variables

pastedata = scale(pastedata)
View(pastedata)

#2. Check for Correlation
#   Variables must be correlated for data reduction

cor(pastedata)
M = round(cor(pastedata),3)
M

# High correlation between V1, V3 & V5
# Good correlation between V2, V4 & V6


library(corrplot)
corrplot(M, method = 'circle')


#3a. Check for sampling/factor adequacy
#    crireria  test statistic  > 0.5
library(psych)


KMO(pastedata)

#3b. Check for correlation
#   Variables must be correlated for factor analysis
# Bartlett's Test of Sphericity: Test for the correlation between variables
#H0: Correlation between variables = 0 
#H1: Correlation between variables not equal to ??? 0

cortest.bartlett(pastedata)

#Since p value (sig.) = 0.00 < 0.05, the variables are correlated

#4. Principle Component Analysis

#Used to identify minimum number of factors accounting for maximum variance in the data
 
# Eigen Values: Amount of variance attributed to a component
# Total Variance = 5.8 (Sum of all Eigen values)
# Prop. variance for PC1= Eigen value of PC1 / Total Variance (2.64014857/5.8 = 0.455)
pca_model = princomp(pastedata)
summary(pca_model)
attributes(pca_model)
pca_model$loadings
plot(pca_model)
eigenvalues


#Step 4b: Determine the number of Components
 
#1. Based on Eigen Values: Only factors with Eigen value > 1.0 are selected
#2. Based on cumulative % variance: Factors extracted should account for at least 65 % of variance

#Step 4c: Determine the number of Factors
 #plot(mymodel)
 
#3. Based on Scree plot: Plot of the eigen values against the number of factors in order of extraction. 
#The number of factors is identified based on slope change of scree plot

 
factor_model = factanal(pastedata, 2)

factor_model


rotated_model = factanal(pastedata, 2, rotation = "varimax", scores ="regression")
rotated_model


output = rotated_model$scores
output
plot(output)

 

cardata = mtcars
dim(cardata)
View(cardata)
zcardata = scale(cardata)
View(zcardata)

cor(zcardata)
M = round(cor(zcardata),3)
M

library(corrplot)
corrplot(M, method = 'circle')

KMO(zcardata)
cortest.bartlett(zcardata)

pca_car_model = princomp(zcardata)
summary(pca_car_model)

plot(pca_car_model)


factor_model = factanal(zcardata, 3)
factor_model


rotated_model = factanal(zcardata, 3, rotation = "varimax", scores ="regression")
rotated_model


output = rotated_model$scores

output
names(output)
class(output)
output_df = as.data.frame(output)
plot(output)

library(rgl)
plot3d(output_df$Factor1,output_df$Factor2,output_df$Factor3, col="red", size=5)
