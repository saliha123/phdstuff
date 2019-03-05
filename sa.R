library(lsa)
library(tm)
library(ggplot2)
library(lsa)
library(scatterplot3d)
library(SnowballC)

scale(tdm.stack)
tran_stack <- t(tdm.stack)
tran_stack <-as.data.frame(tran_stack)
LSAspace <-lsa(tran_stack, dims=dimcalc_share() )

l <- as.textmatrix(LSAspace)
dist.mat.lsa <- dist(t(as.textmatrix(lsaSpace)))



#distance matrix
lsaSpace <- lsa(tdm.stack) 
dist.mat.lsa2 <- dist(as.textmatrix(lsaSpace))


dist.mat <- dist(l)  # compute distance matrix
dist.mat 

wgdis<-print(dist.mat.lsa2, upper=TRUE)



fit <- cmdscale(dist.mat, eig = TRUE, k = 2)

fit <- cmdscale(dist.mat.lsa2, eig = TRUE, k = 2)


points2 <- data.frame(x = fit$points[, 1], y = fit$points[, 2])
yrange<-range(c(points2[,1],points2[,2]))
plot(points2[,1],type="b",ylim=yrange,col=1)
lines(points2[,2],type="b",col=2)


