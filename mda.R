library("MASS")
library(ggfortify)
library(vegan)


# for 204
data2 <- data2[1:204,]
  
data2 <- subset(data2, select = (peersetconceptspca))

data2<-tdm.stack
data2$class <-NULL

data2$class<-NULL
row.names(data2) <- data2[, 1]
row.names(data2) <- data2[, 1391]
data2$X<-NULL

x <- data2
x[] <- lapply(x, as.numeric)
data2 <- x

#--------------------------------------#
data3<-data2
data3$class<-NULL


d <- dist(data3[1:102,])
d2 <- dist(data3[103:408,])

d <- dist(data3)

mds <- isoMDS(d)
mds2 <- isoMDS(d2)


f<-mds$points
nf<-mds2$points


fit <- cmdscale(d, eig = TRUE, k = 2)
fit2 <- cmdscale(d2, eig = TRUE, k = 2)

f<-fit$points
nf<-fit2$points

plot(f, main="Peer Set: FS based on PCA on Rutherford Keywords - MDA results", pch=24, bg="black", col="black")

points(nf, pch=21, bg="red", col="red")


legend("topright", inset=.01,  # places a legend at the appropriate place c("Health","Defense"), # puts text in the legend 
       c("f", "nf"),
       pch=c(24,21),  # gives the legend appropriate symbols (lines)
       cex = 0.75,
       col =  c("black","red"),
       pt.bg =c("black","red")) 





mds<-metaMDS(d, distance = "bray", k = 2, try = 20, trymax = 20, zerodist = "add")
mds2<-metaMDS(d2, distance = "bray", k = 2, try = 20, trymax = 20, zerodist = "add")


f<-mds$points
nf <-mds2$points


plot(f,
  main="Matched Pair: Feature selection by LSA on ngrams - MDA results",bg= "black", col="black", pch =24)

points(nf, pch=21, bg="red", col="red")







