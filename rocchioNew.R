library(tm)
library(SnowballC)
library(ForImp)

reports <- c("nf", "f")
pathname <- "C:/data5"
cname <- sprintf("%s/%s", pathname, reports)

# set options
options(stringsASFactors = FALSE)

#cname <- file.path("C:", "data7")

docs <- VCorpus(DirSource(directory = cname), readerControl = list(reader=readPlain))
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, removeWords, stopwords("english"))
docs <- tm_map(docs, stripWhitespace)
#docs <- tm_map(docs, stemDocument)
tdm <- TermDocumentMatrix(docs,control = list(weighting = function(x) weightTfIdf(x, normalize =TRUE)))
tdm <- removeSparseTerms(tdm, 0.7)
result <- list(name = reports, tdm = tdm)

mdtm <- as.matrix(tdm)
## make matrix fdtm
mdtm <- t(as.matrix(tdm))
mdtm <- as.data.frame(mdtm, stringsASFactors = TRUE)

tdm.stack2<-mdtm

# stack
tdm.stack2 <- do.call(rbind.fill, tdm.stack2)
tdm.stack2[is.na(tdm.stack2)] <- 0


classT <- c(rep("f", times = 50),rep("nf", times = 50))
mdtm <- cbind(mdtm, as.character(classT))
colnames(df2)[1667]<-"classT" 
  
## convert factors to characters

i <- sapply(mdtm, is.factor)
mdtm[i] <- lapply(mdtm[i], as.character)

mdtm<-tdm.stack
mdtm$classT <-NULL
for (m in 1:50)  {
  rownames(mdtm)[m] = paste("nf",rownames(mdtm)[m] , sep=" ")
}

for (m in 51:100)  {
  rownames(mdtm)[m] = paste("f", rownames(mdtm)[m], sep=" ")
}

## randomise the rows
mdtm <- mdtm[sample(nrow(mdtm)),]

## attach class
#x <- c(rep("nf", times = 50),rep("f", times = 50))
#mdtm<-cbind(mdtm, x)

mdtm2<-mdtm[1:50,]
mdtm2 <- mdtm2[sample(nrow(mdtm2)),]
mdtm3<-mdtm[51:100,]
mdtm3 <- mdtm2[sample(nrow(mdtm2)),]


##Rocchio

## get centroid vectors


avgcentnf <- colSums(mdtm[1:35, 1:1876])
avgcentf <- colSums(mdtm[51:85, 1:1876])

avgcentnf<-unname(avgcentnf, force = FALSE)
avgcentf<-unname(avgcentf, force = FALSE)


avgcentnf <-lapply(avgcentnf, function(x) x*(1/35))
avgcentf <-lapply(avgcentf, function(x) x*(1/35))

avgcentnf <-as.numeric(avgcentnf)
avgcentf <- as.numeric(avgcentf)

##test cosine on non fraud set

cosnf1<-apply(mdtm[36:50,1:1876], 1, function(x) vcosw(x,avgcentnf))
cosf1<-apply(mdtm[36:50,1:1876], 1, function(x) vcosw(x,avgcentf))


## Euclidean distance
cosnf1<-apply(mdtm[36:50,1:1876], 1, function(x) sqrt(sum((avgcentnf-x)^2)))
cosf1<-apply(mdtm[36:50,1:1876], 1, function(x) sqrt(sum((avgcentf-x)^2)))

r1 <- data.frame(matrix(ncol = 2, nrow = 16))

colnames(r1)[1]<- "Non fraud"
colnames(r1)[2]<- "fraud"
c<-FALSE

n2<-0
for (m in 1:15) {
  #row.names(r1)[m] <- names(cosnf1)[m]
  r1[m,1]<- cosnf1[m]
  r1[m,2]<- cosf1[m]
  if (r1[m,1] > r1[m,2]){
    n2<-n2+1
  }
 }
message("Non Fraud for Non Fraud Centroid:", n2)

## Euc distance
n2<-0
for (m in 1:15) {
  if (r1[m,1] < r1[m,2]){
    n2<-n2+1
  }
}
message("Non Fraud for Non Fraud Centroid: EUC ", n2)



# test on fraud set

cosnf2<-apply(mdtm[86:100,1:1876], 1, function(x) vcosw(x,avgcentnf))
cosf2<-apply(mdtm[86:100,1:1876], 1, function(x) vcosw(x,avgcentf))


## Euclidean distance
cosnf2<-apply(mdtm[86:100,1:1876], 1, function(x) sqrt(sum((x-avgcentnf)^2)))
cosf2<-apply(mdtm[86:100,1:1876], 1, function(x) sqrt(sum((x-avgcentf)^2)))


r1 <- data.frame(matrix(ncol = 2, nrow = 16))
colnames(r1)[1]<- "Non fraud"
colnames(r1)[2]<- "fraud"


n2<-0
for (m in 1:15) {
  row.names(r1)[m] <- names(cosnf2)[m]
  r1[m,1]<- cosnf2[m]
  r1[m,2]<- cosf2[m]
  if (r1[m,1] < r1[m,2]){
    n2<-n2+1
  }
}
message("Fraud for Fraud Centroid:", n2)



## Euc distance
n2<-0
for (m in 1:15) {
  if (r1[m,1] > r1[m,2]){
    n2<-n2+1
  }
}
message("Fraud for Fraud Centroid: EUC ", n2)



## do one at a time

mysample <- sample(1:nrow(df2), 26,replace=FALSE)

x <- data.frame(matrix(ncol=2, nrow = 10))
tn<-5
for (m in 1:5) {
  x[m,1] <- vcosw(d[m], d[tn])
  x[m,2] <- substr(rownames(mdtm[m,]),1,2) 
}

s <- data.frame(matrix(ncol = 2, nrow = 7))
n<-100

for (m in 1:6)  {
  s[m,1] <- sort(x[,1], TRUE)[n]
  rnum<-which(x[,1] == s[m,1])
  s[m,2] <- x[rnum,2]
  n<-n-1 
}

s[7,2]<- tdm.stack[tn,1600]

s
# end do one at a time
 
## Now try Knn with Euc distance using Caret

library(ISLR)
library(caret)

df2<-tdm.stack
set.seed(300)
#Spliting data as training and test set. Using createDataPartition() function from caret
indxTrain <- createDataPartition(y = df2$classT, p = 0.65,list = FALSE)
training <- df2[indxTrain,]
testing <- df2[-indxTrain,]


ctrl <- trainControl(method="repeatedcv", number=10, repeats=3)
set.seed(12345)

knnFit1 <- train(classT ~ ., data=training, method="knn",
                 trControl=ctrl, metric="Accuracy", tuneLength=20,
                 preProc=c("range"))

knnPredict <- predict(knnFit1,newdata = testing)
confusionMatrix(knnPredict, testing$classT)


##tuneGrid=data.frame(k=1:5)




z2[1]<-sort(z1, TRUE)[1]
z2[2]<-sort(z1, TRUE)[2]
z2[3]<-sort(z1, TRUE)[3]
z2[4]<-sort(z1, TRUE)[4]
z2[5]<-sort(z1, TRUE)[5]
z2[6]<-df2[100,1667]


z2 <- rep(NA,6)
z2[1]<-paste(substr(names (sort(z1, TRUE)[1]), 1,2),sort(z1, TRUE)[1], sep=" ")
z2[2]<-paste(substr(names (sort(z1, TRUE)[2]), 1,2),sort(z1, TRUE)[2], sep=" ")
z2[3]<-paste(substr(names (sort(z1, TRUE)[3]), 1,2),sort(z1, TRUE)[3], sep=" ")
z2[4]<-paste(substr(names (sort(z1, TRUE)[4]), 1,2),sort(z1, TRUE)[4], sep=" ")
z2[5]<-paste(substr(names (sort(z1, TRUE)[5]), 1,2),sort(z1, TRUE)[5], sep=" ")
z2[6]<-df2[100,1667]




for (m in 1:length(z1) ) {
  x[1, m] = round(z1[m], digits=3)
}



##attach column names
for (m in 1:60){
  colnames(x)[m] = paste(df2[m,1667], m, sep=" ")
}

while(i <= N){
  z1 <- apply(df2[1:60,1:1666], 1, function(x) vcosw(x,df2[i1,1:1666]))
  
for (m in 1:length(z1) ) {
  x[i3, m] = round(z1[m], digits=3)
  }
x[i3, 61] = df2[i1, 1667]

i3 <-1+i3
i1 <- i1+1
i <-i+1
}


s <- data.frame(matrix(ncol = 4, nrow = 40))

for (c in 1:nrow(x) ) {
s[c,1] <- paste(sort(x[c,1:60], TRUE)[1],colnames(sort(x[c,1:60], TRUE)[1]), sep=" ")
s[c,2] <- paste(sort(x[c,1:60], TRUE)[2],colnames(sort(x[c,1:60], TRUE)[2]), sep=" ")
s[c,3] <- paste(sort(x[c,1:60], TRUE)[3],colnames(sort(x[c,1:60], TRUE)[3]), sep=" ")
s[c,4] <- x[c,61]
}



m = matrix(rep(3, 30), 2,2) 

##practice matrix multip
m = matrix(rep(3, 30), 5,6) 

## calculate document vectors         
mdtm1 <- mdtm * mdtm
l1 <- apply(mdtm1, 1, sum)
l1 <- as.list(l1)
dv<-lapply(l1, sqrt)

freq <- colSums(as.matrix(dtm))
ord <- order(freq)

freq[head(ord)]
freq[tail(ord)]



data(iris)
dat <- as.matrix(iris[,-5])
pca <- prcomp(dat, retx=TRUE, center=TRUE, scale=TRUE)




