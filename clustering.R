library(dendextend)
library(proxy)
library(dendroextras)
# set options
options(stringsASFactors = FALSE)

cname <- file.path("C:", "data7")
docs <- VCorpus(DirSource(directory = cname), readerControl = list(reader=readPlain))

# Ward Hierarchical Clustering
mydata <- scale(tdm.stack2) # standardize variables
d <- dist(mydata, method="cosine") # distance matrix
fit <- hclust(d, method="ward") 
plot(fit) # display dendogram
groups <- cutree(fit, k=2) # cut tree into 5 clusters


# draw dendogram with red borders around the 5 clusters 
c<-rect.hclust(fit, k=2, border="red")
dd <- as.dendrogram(fit)
order.dendrogram(dd) ## the same :



table(groups)
labels(dd)
table(groups, tdm.stack$classT)

x1<- subset(tdm.stack2, groups==1)


## kmeans

df <- read.csv("C:/data6/matrixOrigcsv.csv", header=TRUE)
dtm <-DocumentTermMatrix(docs)
dtmtfidf<-weightTfIdf(dtm)
m1<-as.matrix(dtmtfidf)


tdm.stack2 <- tdm.stack
tdm.stack2$classT <-NULL
mydata <- scale(tdm.stack2) # standardize variables


mydata<-as.data.frame(mydata)


norm_eucl <-function(m)
m/apply(m,1,function(x) sum(x^2)^.5)
mydata <-norm_eucl(tdm.stack2)

library(flexclust)

set.seed(42)
results <-kmeans(mydata,2,30)
tr<-table(tdm.stack$classT, results$cluster)
tr
table(results$cluster)
randIndex(tr)


library(cluster)
library(fpc)
library(HSAUR)

plotcluster(results$cluster)

dissE <- daisy(mydata) 
dE2   <- dissE^2
sk2   <- silhouette(results$cl, dE2)
plot(sk2)

clusters <- 1:2
for (i in clusters){
  cat("Cluster ", i, ":", findFreqTerms(dtmtfidf[results$cluster==i],2),"\n\n")
}



#now hierarchical
hc.complete <-hclust(dist(x), method ="euclidean")
hc.single <-hclust(dist(x), method ="single")

plot(hc.complete, main="hier clustering",cex=0.9)


## skmeans from 
library(skmeans) 
# tdm a doc term matrix
tdm <-scale(tdm)
hparty <- skmeans(tdm, 2, control = list(verbose = TRUE))
classK <- rep(0, times=100)

for (m in 1:50) { 
  classK[m]<-1
}

table(classK, hparty$cluster)