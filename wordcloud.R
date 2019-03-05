library(tm)
library(plyr)
library("SnowballC")
library("RColorBrewer")
library("wordcloud")
library(RWeka)
# Trigrams
require(RWeka)


set.seed(123)


MyData <- read.csv(file="C:/data6/wa/concepts/Final Concepts 408_matrix csv.csv", header=TRUE, sep=",")

MyData <- read.csv(file="C:/data6/wa/Dictionaries/L&M Sentimentsv8csv.csv", header=TRUE, sep=",", stringsAsFactors=FALSE)
MyData <- read.csv(file="C:/data6/wa/Coh_Metrix/cohall.csv", header=TRUE, sep=",")
MyData <- read.csv(file="C:/data6/wa/Dictionaries/LMdict.csv", header=TRUE, sep=",")

MyData <- read.csv(file="C:/data6/wa/topicmallet/LMdict.csv", header=TRUE, sep=",")



MyData <- read.csv(file="C:/data6/wa/topicmallet/topicscsvall.csv", header=TRUE, sep=",")

data2 <-sdfotWSt
data2 <-tdm.stack
data2$classT <- NULL

data2 <- MyData

data2$class<-NULL
data2$file <-NULL

data2$X<-NULL
data2$Filename <-NULL


data2 <- scale(data2)



rep <- c("f","nfall")
path <- "C:/data5"

#cname <- file.path("C:", "data5", "nfall" )
#doc <- VCorpus(DirSource(directory = cname), readerControl = list(reader=readPlain))


s.dir <- sprintf("%s/%s", path, rep)
doc <- VCorpus(DirSource(directory = s.dir), readerControl = list(reader=readPlain))
doc <- tm_map(doc, content_transformer(tolower))
doc <- tm_map(doc, removeNumbers)
doc <- tm_map(doc, removePunctuation)
doc <- tm_map(doc, removeWords, stopwords("english"))
doc <- tm_map(doc, stripWhitespace)
tdm <- DocumentTermMatrix(doc,control = list(weighting = function(x) weightTfIdf(x, normalize =TRUE)))

tdm <- TermDocumentMatrix(doc,control = list(weighting = function(x) weightTfIdf(x, normalize =TRUE)))

data2 <-tdm.stack
data2$classT <- NULL
data2 <- sdfotWSt
data2$classT <- NULL

HighFreq <- findFreqTerms(tdm[103:408,], 100, Inf)
tdmM<-as.matrix(tdm)

freqd <- sort(colSums(data2[103:408,]), decreasing=TRUE)
m<-as.matrix(freqd)

m[,order(colSums(m))]
data2 <-as.data.frame(data2)
data2 <- data2[,order(colSums(data2))]


x1 <-colSums(m)

relfreq<- apply(m, 2, function(x) x/x1)
normfreq<- apply(m, 2, function(x) (x/x1)*1000)

m <-cbind(m, relfreq)
m <-cbind(m, normfreq)

colnames(m)[1] <- "Raw Freq"
colnames(m)[2] <- "Rel Freq"
colnames(m)[3] <- "Norm Freq"


write.csv(m, file = "c:/temp3/Freqm.csv")

freq2 <- sort(colSums(tdmM[103:204,]), decreasing=TRUE)
freq3 <- sort(colSums(tdmM[205:306,]), decreasing=TRUE)
freq4 <- sort(colSums(tdmM[307:408,]), decreasing=TRUE)


m2<-as.matrix(freq2)
m3<-as.matrix(freq3)
m4<-as.matrix(freq4)

x2 <-colSums(m2)
x3 <-colSums(m3)
x4 <-colSums(m4)


relfreq2<- apply(m2, 2, function(x) x/x2)
normfreq2<- apply(m2, 2, function(x) (x/x2)*1000)

relfreq3<- apply(m3, 2, function(x) x/x3)
normfreq3<- apply(m3, 2, function(x) (x/x3)*1000)

relfreq4<- apply(m4, 2, function(x) x/x4)
normfreq4<- apply(m4, 2, function(x) (x/x4)*1000)


m2 <-cbind(m2, relfreq2)
m2 <-cbind(m2, normfreq2)

m3 <-cbind(m3, relfreq4)
m3 <-cbind(m3, normfreq4)

m4 <-cbind(m4, relfreq4)
m4 <-cbind(m4, normfreq4)


data<-data.frame(m[,1],m2[,1],m3[,1],m4[,1])
                
colnames(data)[1] <- "Fraud"
colnames(data)[2] <- "Non Fraud 1"
colnames(data)[3] <- "Non Fraud 2"
colnames(data)[4] <- "Non Fraud 3"




boxplot(data, main=toupper("Normalised Frequencies"), xlab="Type of Report", ylab="Normalised Frequency Score")




colnames(m2)[1] <- "Raw Freq"
colnames(m2)[2] <- "Rel Freq"
colnames(m2)[3] <- "Norm Freq"










write.csv(m2, file = "c:/temp3/Freqm2.csv")


## perform t test

##t.test(m[,3],m2[,3],alternative="greater", var.equal=TRUE)

t.test(m[,3],m2[,3], var.equal=TRUE, paired=FALSE)

## value of t-computed is less than the tabulated t-value for 18 degrees of freedom,
qt(0.975, 65344)


x<-c(mean(m[,1]), mean(m[,2]), mean(m[,3]), mean(m2[,1]), mean(m2[,2]), mean(m2[,3]))
Mean1<-matrix(c(x),nrow = 2,dimnames = list(c("Fraud", "Non Fraud"), c("raw", "rel", "norm")))
                                      

fisher.test(Mean1)


###sep out frauf coh results from non fraud


FraudC <- read.csv(file="C:/data6/wa/fraudCOH.csv", header=TRUE, sep=",")
nfc <- read.csv(file="C:/data6/wa/nfCOH.csv", header=TRUE, sep=",")

t.test(FraudC[2:2], nfc[2:2])

D <- matrix(nrow=111, ncol=2)
for(i in 1:110){
  s<-t.test(FraudC[i:i], nfc[i:i])
  if (s$p.value < 0.05){
  D[i,1]<-colnames(FraudC)[i]
  D[i,2]<-s$p.value
  }
}
  
  
  usq[i]<-u1[i]*u1[i] # i-th element of u1 squared into i-th position of usq
  print(usq[i])
}







HighFreq <- findFreqTerms(tdm[1:102,], 1000, Inf)

freq <- sort(colSums(tdmM[103:408,]), decreasing=TRUE)
d <- data.frame(word = names(freq),freq=freq)



wordcloud(words = d$word, freq = d$freq, min.freq = 1000,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))

 
wordcloud(names(r), r,scale=c(2,.2),random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))



barplot(d[1:10,]$freq, las = 2, names.arg = d[1:10,]$word,
        col ="lightblue", main ="Most Frequent Words by TF-IDF score for Non-Fraud Firms",
        ylab = "TF-IDF Scores")





### Fraud Set
docf <- VCorpus(DirSource(directory = cname2), readerControl = list(reader=readPlain))

docf <- tm_map(docf, content_transformer(tolower))
docf <- tm_map(docf, removeNumbers)
docf <- tm_map(docf, removePunctuation)
docf <- tm_map(docf, removeWords, stopwords("english"))
docf <- tm_map(docf, stripWhitespace)
tdmf <- TermDocumentMatrix(docf)


HighFreq <- findFreqTerms(tdmf, 50, Inf)
tdmf1<-as.matrix(tdmf)
freq <- sort(rowSums(tdmf1), decreasing=TRUE)
head(freq, 25)
tail(freq, 25)
r <-head(freq, 25)





library(wordcloud)
set.seed(123)

wordcloud(names(r), r,scale=c(2,.2))
wordcloud(names(r), r)



df<-as.data.frame(df)

chisq.test(df[1:2,2:198])

t.test(df[1,2:198],df[2,2:198],paired=TRUE) # where y1 & y2 are numeric

