
#clean text

cleanCorpus <- function(corpus) {
  corpus.tmp <- tm_map(corpus, removePunctuation)
  corpus.tmp <- tm_map(corpus.tmp, stripWhitespace)
  corpus.tmp <- tm_map(corpus.tmp, tolower)
  corpus.tmp <- tm_map(corpus.tmp, removeWords, stopwords("english"))
  return(corpus.tmp)
}

#build tdm


generateTDM <- function(subj, path) {  
  s.dir <- sprintf("%s/%s", path, subj) 
  s.cor <- Corpus(DirSource(directory = s.dir, encoding = "ANSI"))
  s.cor.cl <- cleanCorpus(s.cor)
  s.tdm <- TermDocumentMatrix(s.cor.cl)
  s.tdm <- removeSparseTerms(s.tdm, 0.7)
  result <- list(name = subj, tdm = s.tdm)
}

tdm <-lapply(submat, generateTDM, path = pathname)


#attach name


#stack


#hold-out

#model -knn

#accuracy
