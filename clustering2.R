library(cluster)
library(fpc)
library(HSAUR)

data3<-data2
data3$class<-NULL

data3 <- scale(data3) # standardize variables
data3Cluster <- kmeans(data3, 2, nstart = 30)
table(data3Cluster$cluster)
data3Cluster$withinss
data3Cluster$betweenss

table(data3Cluster$cluster, data2$class)
par(mgp=c(2,1,0))
plotcluster(data2[,1:30], data3Cluster$cluster)
title("Keywords Rutherford: kmeans clustering using IG selected features", line = 0.6)








dissE <- daisy(data3) 
#dE2   <- dissE^2
sk2   <- silhouette(data3Cluster$cluster, dissE)
plot(sk2)