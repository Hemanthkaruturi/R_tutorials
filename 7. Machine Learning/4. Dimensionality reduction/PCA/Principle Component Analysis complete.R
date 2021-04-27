data = read.csv('Credit_Fraud.csv', header=T)
dim(data)
View(data)

# get the list of column index that are numeric
numvec=c() 

for( i in 1:ncol(data)){
    if ( is.numeric(data[,i])) numvec = append(numvec,i)
}
cat('Numeric columns # ', numvec, "\n")
#cat('Numeric columns # ', numvec)

# let subset the numeric variable and plots the box plots to see their distribution approximately

datn = data[,numvec]
head(datn)

#Do we need to standardize ( location and scale) ? or 
#do we need any kind of transformation before doing location/scale standardization ?

#How can we reduce these 7 features into a smaller number of features, 
#such that at least 60 to 70% of the variability is explained by these newly obtained features;
#thus reducing the size of the data, also known as dimensionality reduction?

# Perform a principal component analysis on the data and print the results
pcasolutions = prcomp(datn, center=TRUE, scale=TRUE)

print(pcasolutions)

 
options(warn=-1)
if ( length(pcasolutions$scale)==1 & !(pcasolutions$scale)) { 
    cat(" Scaling of variables is necessary here, ... did you make use of \"scale=TRUE\" option ? ")
}else{
    cat(" passed ....")
}

options(warn=0)
    

#Creating a scree plot

#eigen-values : 
eigenvalues = pcasolutions$sdev**2

# cumulative proportion of variance explained by each principal component:
prop = cumsum(eigenvalues)/sum(eigenvalues)
prop
plot(prop, type="b", ylab="proportion of variance explained", xlab="# of principal components")


# taking a look at the first three PCs 
rotated_data = pcasolutions$x[,1:3]
head(rotated_data)


# Rotation gives you the factor loadings # 
eigenvectors = pcasolutions$rotation[,1:3]



# some colouring based on other categorical variables;
catcol = 'class'
colcolumn  = data[,catcol]
l1 = levels(colcolumn)
colpalatte = c('green','blue', 'cyan')
mycol =colpalatte[as.numeric(colcolumn)]
head(mycol)    

#install.packages("plot3D")
library(plot3D)

plot(rotated_data[,1],rotated_data[,2],pch=20, col=mycol, xlab="First PC", ylab="Second PC",
     main=paste('Plot of First 2 PC (colour by :',catcol, ")"))
legend(3.6,4, legend =l1, pch=20, col=colpalatte[1:length(l1)])

plot(rotated_data[,2],rotated_data[,3],pch=20, col=mycol, xlab="Second PC", ylab="Third PC",
     main=paste('Plot of 2nd and 3rd PC (colour by :',catcol, ")"))
legend(3,3.5, legend =l1, pch=20, col=colpalatte[1:length(l1)])

#The spread of the class is fairly intertwined indicating that principal components 
#don't segregate the response.