libs <- c("tm", "plyr", "class")
library(MASS)
library(kernlab)
library(e1071)
library(gbm)
library(dplyr)
library(glmnet)
library(maxent)
library(xlsx)
library(tm)
library(RWeka)
# Trigrams
require(RWeka)
lapply(libs, require, character.only = TRUE)
# set options
options(stringsASFactors = FALSE)
reports2 <- c("f","nfall")
pathname2 <- "C:/data5"
s.dir2 <- sprintf("%s/%s", pathname2, reports2)

#s.cor <- Corpus(DirSource(directory = s.dir, encoding = "ANSI"))
s.cor2 <- VCorpus(DirSource(directory = s.dir2), readerControl = list(reader=readPlain))
s.cor2 <- tm_map(s.cor2, content_transformer(tolower))
#s.cor2 <- tm_map(s.cor2, removeWords, stopwords("english"))
s.cor2 <- tm_map(s.cor2, removeNumbers)
s.cor2 <- tm_map(s.cor2, removePunctuation)
tdmf <- TermDocumentMatrix(s.cor2)
tdmf <- as.matrix(tdmf)

TrigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
#tdmf <- TermDocumentMatrix(s.cor2, control = list(tokenize = TrigramTokenizer))
tdmf <- TermDocumentMatrix(s.cor2, control = list(tokenize = TrigramTokenizer, weighting =function(x) weightTfIdf(x, normalize =TRUE )))

tdmf <- removeSparseTerms(tdmf, 0.75)
s.mat <-as.matrix(tdmf)
s.mat <- t(s.mat)
sdfotWSt <- as.data.frame(s.mat, stringsASFactors = FALSE)



dtm<-DocumentTermMatrix(s.cor2,control=list(weighting=function(x) weightTfIdf(x,normalize=T), tokenize = TrigramTokenizer))

dtm <- removeSparseTerms(dtm, 0.75)

s.mat <-as.matrix(dtm)


s.mat <- t(s.mat)
data3 <- as.data.frame(s.mat, stringsASFactors = FALSE)

sdfotWS <- as.data.frame(s.mat, stringsASFactors = FALSE)


#create a new object using the 'tfidf' function on the previously made matrix object
specialweight<-tfidf(sdfotWS,normalize=TRUE)
sdfotWS <- as.data.frame(specialweight, stringsASFactors = FALSE)



RepT <- c(rep("f", times = 102),rep("nf", times = 306))
class<- factor(RepT)

data3<- data2
data3 <-sdfotWSt
data3 <- cbind(data3, class)

