#init
libs <- c("tm", "plyr", "class")
library(MASS)
library(kernlab)
library(e1071)
library(gbm)
library(dplyr)
library(glmnet)
library(maxent)
library(class)


lapply(libs, require, character.only = TRUE)

# set options
options(stringsASFactors = FALSE)

# set Parameters
reports <- c("f","nfall")
pathname <- "C:/data5"

#clean text
cleancorpus <-function(corpus){
corpus.tmp <- tm_map(corpus, removePunctuation)
corpus.tmp <- tm_map(corpus.tmp, content_transformer(tolower))
corpus.tmp <- tm_map(corpus.tmp, removeNumbers)
corpus.tmp <- tm_map(corpus.tmp, removeWords, stopwords("english"))
corpus.tmp <- tm_map(corpus.tmp,  stemDocument) 
corpus.tmp <- tm_map(corpus.tmp, stripWhitespace)
return(corpus.tmp)
}

#build TDM

generateTDM <- function(rep, path){
  s.dir <- sprintf("%s/%s", path, rep)
  s.cor <- VCorpus(DirSource(directory = s.dir), readerControl = list(reader=readPlain))
  s.cor.cl <- cleancorpus(s.cor)
  s.tdm <- TermDocumentMatrix(s.cor.cl,control = list(weighting = function(x) weightTfIdf(x, normalize =TRUE)))
  s.tdm <- removeSparseTerms(s.tdm, 0.7)
  result <- list(name = rep, tdm = s.tdm)
}

tdm <- lapply(reports, generateTDM, path = pathname)  

#attach name


bindReportTDM <-function(tdm){
  s.mat <-t(data.matrix(tdm[["tdm"]]))
  s.df <- as.data.frame(s.mat, stringsASFactors = TRUE)
  s.df <-cbind(s.df, rep(tdm[["name"]], nrow(s.df)))
  colnames(s.df)[ncol(s.df)]<-"classT"
  return(s.df)
}

reportTDM <- lapply(tdm, bindReportTDM)

# stack
tdm.stack <- do.call(rbind.fill, reportTDM)
tdm.stack[is.na(tdm.stack)] <- 0

##__________________________________##





tdm.stack <- tdm.stack[sample(nrow(tdm.stack)),]


#hold 
train.idx <- sample(nrow(tdm.stack), ceiling(0.7*nrow(tdm.stack)))
test.idx <- (1:nrow(tdm.stack))[- train.idx]

# model - KNN
tdm.rep <- tdm.stack[, "classT"]
tdm.stack.nl <- tdm.stack[, !colnames(tdm.stack) %in% "classT"]

knn.pred <-knn(tdm.stack.nl[train.idx,], tdm.stack.nl[test.idx,], tdm.rep[train.idx], k=5)

#accuracy
conf.mat <- table("Predictions" = knn.pred, Actual = tdm.rep[test.idx])
accuracy <- sum(diag(conf.mat))/length(test.idx)*100


# train the SVM model
#SVM <- svm(x(trainDTM), as.factor(traindata$CLASS))
SVMmodel  <- svm(ReportType~., data = tdm.stack[train.idx,])

#predict classes using the test set in order to verify if the model has good generalization
SVMpredict <- predict(SVMmodel, tdm.stack[test.idx,][,-1607])
#accuracy
tab <- table(pred = SVMpredict, true = tdm.stack[test.idx,][,1607])
accuracy <- sum(diag(conf.mat))/length(test.idx)*100

##gbm model stochastic gradient boosting 

# tdm.rep contains value of dependent variable
tdm.rep
modelgbm <- tdm.stack[, -1607]
ntrees = 1000
end_train = nrow(modelgbm)


### gbm model stochastic gradient boosting  not working
gbmmodel <- gbm.fit(x=modelgbm, y=tdm.rep, distribution = "bernoulli",n.trees = ntrees,shrinkage =0.01, interaction.depth = 3, n.minobsinnode = 10, nTrain =round(end_train*0.8), verbose=TRUE)
#testpredictions = predict(object=gbmmodel, newdata = modelgbm, n.trees=gbm.perf(gbmmodel, plot.it=FALSE), type = "response")
gbmmodel <- gbm(ReportType~.,data=tdm.stack, distribution = "bernoulli",n.trees = ntrees,shrinkage =0.01, interaction.depth = 3, n.minobsinnode = 10,  verbose=TRUE)
prediction <- predict.gbm(gbmmodel, tdm.stack[45:55,], type="response", n.trees=1000)


#note alpha =1 for lasso only and can blend with ridge penalty down to alpha=0 ridge only
### Generlised Linear Model
glmtrainNC <-as.matrix(tdm.stack[train.idx,][,-1607])
glmtestNC <- as.matrix(tdm.stack[test.idx,][,-1607])
glmtrainOC <-tdm.stack[train.idx,][,1607]

glmmod<-cv.glmnet(glmtrainNC,y=glmtrainOC, alpha=1,family='binomial')

glmpredict <- predict(glmmod, newx=glmtestNC, type="class")

act <- tdm.stack[test.idx,][,1607]
#accuracy
tab <- table(pred = glmpredict, true = act)

