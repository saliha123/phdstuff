library(tm)
library(SnowballC)
library(ForImp)

reports <- c("0", "1")
pathname <- "C:/data5"
s.dir <- sprintf("%s/%s", pathname, reports)
docs <- VCorpus(DirSource(directory = s.dir), readerControl = list(reader=readPlain))


# set options
options(stringsASFactors = FALSE)


#cname <- file.path("C:", "data7")
#docs <- VCorpus(DirSource(directory = cname), readerControl = list(reader=readPlain))
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, removeWords, stopwords("english"))
docs <- tm_map(docs, stripWhitespace)
#docs <- tm_map(docs, stemDocument)


tdm <- TermDocumentMatrix(docs, control = list(weighting = weightTfIdf))
tdm <- removeSparseTerms(tdm, 0.7)

## make matrix from dtm
mdtm <- t(as.matrix(tdm, stringsASFactors = FALSE))
mdtm <- as.data.frame(mdtm, stringsASFactors = FALSE)

class <- c(rep("nf", times = 50),rep("f", times = 50))
mdtm <- cbind(mdtm, class)

## randomise the rows
df2 <- mdtm[sample(nrow(mdtm)),]


## attach class
#x <- c(rep("nf", times = 50),rep("f", times = 50))
#mdtm<-cbind(mdtm, x)

## get centroid vectors

avgcentnf <- colSums(mdtm[1:38 , ])
avgcentf <- colSums(mdtm[50:88 , ])

avgcentnf <-as.list(avgcentnf)
avgcentf <-as.list(avgcentf)

avgcentnf <-lapply(avgcentnf, function(x) x*(1/38))
avgcentf <-lapply(avgcentf, function(x) x*(1/38))

avgcentnf <-as.numeric(avgcentnf)
avgcentf <- as.numeric(avgcentf)


cosnf1<-apply(mdtm[39:50, ], 1, function(x) vcosw(x,avgcentnf))
cosnf2<-apply(mdtm[39:50, ], 1, function(x) vcosw(x,avgcentf))


cosf1<-apply(mdtm[89:100, ], 1, function(x) vcosw(x,avgcentnf))
cosf2<-apply(mdtm[89:100, ], 1, function(x) vcosw(x,avgcentf))


## apply KNN using Cosine





i<-1
i1 <-40
i2 <-90
N  <-11
i3 <-1  

## Non fraud data set get cosines with test set 40-50
x <- data.frame(matrix(ncol = 40, nrow = 44))

while(i <= N){
  z1 <- apply(mdtm[1:39, ], 1, function(x) vcosw(x,mdtm[i1,]))
  z2 <- apply(mdtm[51:89, ], 1, function(x) vcosw(x,mdtm[i1,]))
  z3 <- apply(mdtm[1:39, ], 1, function(x) vcosw(x,mdtm[i2,]))
  z4 <- apply(mdtm[51:89, ], 1, function(x) vcosw(x,mdtm[i2,]))

  
for (m in 1:length(z1) ) {
  x[i3, m] = z1[m]
}
x[i3,40]<-"nf"
i3<-1+i3

for (m in 1:length(z3) ) {
  x[i3, m] = z3[m]
}
x[i3,40]<-"nf"
i3<-1+i3


for (m in 1:length(z2) ) {
  x[i3, m] = z2[m]
}
x[i3,40]<-"f"
i3<-1+i3


for (m in 1:length(z4) ) {
  x[i3, m] = z4[m]
}
x[i3,40]<-"f"
i3 <- i3+1

i1 <- i1+1
i2<-i2+1
i<-i+1
}


s <- data.frame(matrix(ncol = 4, nrow = 44))

for (c in 1:nrow(x) ) {
s[c,1]<-sort(x[c,1:39], TRUE)[1]
s[c,2]<-sort(x[c,1:39], TRUE)[2]
s[c,3]<-sort(x[c,1:39], TRUE)[3]
s[c,4]<-x[c,40]
}

colnames(s)[1] <- "Max"
colnames(s)[2]<- "2nd Max"
colnames(s)[3]<- "3rd Max"





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
