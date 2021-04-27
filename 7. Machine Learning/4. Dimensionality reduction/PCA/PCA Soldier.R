
sldata = read.csv('Soldier.csv')
View(sldata)
str(sldata)

sldata = sldata[,c(-1)]

# check col.means and sd
colMeans(sldata)
apply(sldata,2,sd)


# Perform scaled PCA: pr.out
pr.out = prcomp(sldata, scale = T)

# model output
summary(pr.out)

# Rotations
pr.out$rotation

# Projections
head(pr.out$x)

# Visualize
biplot(pr.out)

sldata[c(231,430),]

# Variability of each principal component: pr.var
pr.var <- pr.out$sdev^2

# Variance explained by each principal component: pve
pve <- pr.var / sum(pr.var)
pve

# Scree plots


# Plot variance explained for each principal component
plot(pve, xlab = "Principal Component",
     ylab = "Proportion of Variance Explained",
     ylim = c(0, 1), type = "b")

# Plot cumulative proportion of variance explained
plot(cumsum(pve), xlab = "Principal Component",
     ylab = "Cumulative Proportion of Variance Explained",
     ylim = c(0, 1), type = "b")


