libs <- c("tm", "plyr", "class")
library(MASS)
library(kernlab)
library(e1071)
library(gbm)
library(dplyr)
library(glmnet)
library(maxent)


lapply(libs, require, character.only = TRUE)

# set options
options(stringsASFactors = FALSE)

# set Parameters
reports <- c("f", "nf")
pathname <- "C:/data5"

#clean text

cleancorpus <-function(corpus){
  corpus.tmp <- tm_map(corpus, removePunctuation)
  #corpus.tmp <- tm_map(corpus.tmp, tolower)
  corpus.tmp <- tm_map(corpus.tmp, content_transformer(tolower))
  corpus.tmp <- tm_map(corpus.tmp, removeNumbers)
  corpus.tmp <- tm_map(corpus.tmp, removeWords, stopwords("english"))
  corpus.tmp <- tm_map(corpus.tmp, stripWhitespace)
  return(corpus.tmp)
}

#build TDM

generateTDM <- function(rep, path){
  s.dir <- sprintf("%s/%s", path, rep)
  #s.cor <- Corpus(DirSource(directory = s.dir, encoding = "ANSI"))
  s.cor <- VCorpus(DirSource(directory = s.dir), readerControl = list(reader=readPlain))
  s.cor.cl <- cleancorpus(s.cor)
  s.tdm <- TermDocumentMatrix(s.cor.cl) 
  s.tdm <- removeSparseTerms(s.tdm, 0.7)
  result <- list(name = rep, tdm = s.tdm)
}

tdm <- lapply(reports, generateTDM, path = pathname)  

#attach name

bindReportTDM <-function(tdm){
  s.mat <-t(data.matrix(tdm[["tdm"]]))
  s.df <- as.data.frame(s.mat, stringsASFactors = FALSE)
  s.df <-cbind(s.df, rep(tdm[["name"]], nrow(s.df)))
  colnames(s.df)[ncol(s.df)]<-"ReportType"
  return(s.df)
}

reportTDM <- lapply(tdm, bindReportTDM)

# stack
tdm.stack <- do.call(rbind.fill, reportTDM)
tdm.stack[is.na(tdm.stack)] <- 0

#hold out

train.idx <- sample(nrow(tdm.stack), ceiling(0.7*nrow(tdm.stack)))
test.idx <- (1:nrow(tdm.stack))[- train.idx]

# model - KNN
tdm.rep <- tdm.stack[, "ReportType"]
tdm.stack.nl <- tdm.stack[, !colnames(tdm.stack) %in% "ReportType"]

knn.pred <-knn(tdm.stack.nl[train.idx,], tdm.stack.nl[test.idx,], tdm.rep[train.idx])

#accuracy
conf.mat <- table("Predictions" = knn.pred, Actual = tdm.rep[test.idx])
accuracy <- sum(diag(conf.mat))/length(test.idx)*100
