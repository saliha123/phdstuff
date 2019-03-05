#init

lib <-c("tm","plyr", "class")
lapply(lib, require, character.only = TRUE)

#set options
options(stringAsFactors = FALSE)

#Set Parameters
submat <-c("atheism", "space")
pathname <- "C:/exercises/news1"

dump("cleanCorpus", file="myfunctions1.R")
dump("generateTDM", file="myfunctions1.R")
source("myfunctions1.R")

#build tdm

tdm <-lapply(submat, generateTDM, path = pathname)


#attach name
bindcandidateToTDM <-function(tdm) {
  s.mat <- t(data.matrix(tdm[["tdm"]]))
  s.df <- as.data.frame(s.mat, stringASFactors = FALSE)
  
  
  s.df <-cbind(s.df, rep(tdm[["name"]], nrow(s.df)))
  colnames(s.df)[ncol(s.df)] <- "targetcandidate"
  return(s.df)
}

candTDM <- lapply(tdm, bindcandidateToTDM)


# stack

tdm.stack <- do.call(rbind.fill, candTDM)
tdm.stack[is.na(tdm.stack)] <-0




# hold-out


train.idx <- sample(nrow(tdm.stack), ceiling(nrow(tdm.stack) * 0.7))
test.idx <- (1:nrow(tdm.stack)) [-train.idx]



# model -KNN

tdm.subj <- tdm.stack [, "targetcandidate"]
tdm.stack.nl <-tdm.stack[, !colnames(tdm.stack) %in% "targetcandidate"]

knn.pred <-knn(tdm.stack.nl[train.idx,], tdm.stack.nl[test.idx,],tdm.subj[train.idx])


# accuracy

conf.mat <- table ("predictions" = knn.pred, Actual = tdm.subj[test.idx])

(accuracy <- sum(diag(conf.mat)) / length(test.idx)*100)


