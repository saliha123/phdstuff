#init
libs <- c("tm", "plyr", "class")
library(MASS)
library(kernlab)
library(e1071)
library(gbm)
library(dplyr)
library(glmnet)
library(maxent)
library(xlsx)
library(caret)
library(kernlab)
library(ROCR)

# Read CSV into R

MyData <- read.csv(file="C:/data6/wa/LMrel.csv", header=TRUE, sep=",")
MyData <- read.csv(file="C:/temp3/topics25.csv", header=TRUE, sep=",")
MyData <- read.csv(file="C:/temp/MyData.csv", header=TRUE, sep=",")
MyData <- read.csv(file="C:/data6/cohmetrix204v2.csv", header=TRUE, sep=",")

MyData <- read.csv(file="C:/data6/wa/L&M Sentiments204v7.csv", header=TRUE, sep=",")

data3 <- MyData
data3<-data2
data3$Fraud.Non.Fraud.Firms<-NULL
data3$X<-NULL
data3$X.1<-NULL
data3$X.2<-NULL

data3<- as.data.frame(MyData)

data3[is.na(data3)] <- 0

RepT <- c(rep("f", times = 102),rep("nf", times = 102))
class<- factor(RepT)
data3<-cbind(data3, class)


set.seed(998)
inTrainingG <- createDataPartition(data3$class, p = .75, list = FALSE)
trainingG <- data3[ inTrainingG,]
testingG  <- data3[-inTrainingG,]


cvIndex <- createMultiFolds(data3$class, times = 10)
ctrl <- trainControl(method = "repeatedcv", repeats = 5, classProbs = TRUE,summaryFunction = twoClassSummary, allowParallel = FALSE,index = cvIndex)


bootcontrol <- trainControl(method = "repeatedcv",
                            number = 10,
                            repeats = 3,
                            ## Estimate class probabilities
                            classProbs = TRUE,
                            ## Evaluate performance using 
                            ## the following function
                            summaryFunction = twoClassSummary)


###gbm model stochastic gradient boosting   72 per cent on ratios/64
gbmGrid <- expand.grid(n.trees = 200, interaction.depth = 10, shrinkage = 0.1, n.minobsinnode = 10) 


gbmGrid <-  expand.grid(interaction.depth = c(1, 5, 9),
                        n.trees = (1:30)*50,
                        shrinkage = 0.1,
                        n.minobsinnode = 20)

gbmFit <- train(class ~ ., data = trainingG, method = "gbm", trControl = bootcontrol, verbose = FALSE,bag.fraction = 0.5, tuneGrid = gbmGrid)

gbmFit 
testingG<- testingG[complete.cases(testingG),]

gbmClasses <- predict(gbmFit, newdata = testingG)
gbmProbs <- predict(gbmFit, newdata = testingG, type = "prob")

pred <- factor(gbmClasses)
truth <- factor(testingG$class)

caret::confusionMatrix(pred, truth)


binary_eval(pred, truth)
.
## random forest accuracy 70 percent boruta 76 per cent with ratios  84 

ctrlgb = trainControl(method="repeatedcv", number=10, repeats=3, selectionFunction = "oneSE", preProc = c("center", "scale"))
#ctrlgb = trainControl(method="repeatedcv", number=10, repeats=3, selectionFunction = "oneSE")

trf = train(class ~.,  data=trainingG, method="rf", metric="kappa", trControl=ctrlgb)
trfclasses <- predict(trf, newdata = testingG)
trfProbs <- predict(trf, newdata = testingG, type = "prob")

pred <- factor(trfclasses)
truth <- factor(testingG$class)

caret::confusionMatrix(pred, truth)


## tree based package  60 percent with ratios 76
## Classification and Regression Trees
##treeFit <- train(traindata$category~., data=traindata,
##trControl=cvControl, method="rpart", tuneLength=10)
## could use
##cvControl <- trainControl(method="repeatedcv", number=10, repeats=5)

library(caret)
cvCtrlT <- trainControl(method = "repeatedcv", repeats = 3, summaryFunction = twoClassSummary, classProbs = TRUE)
set.seed(1)
treeFit <- train(class ~ ., data = trainingG, method = "rpart", tuneLength = 30, metric = "ROC", trControl = cvCtrlT)
plot(treeFit, scales = list(x = list(log = 10)))
treeClasses <- predict(treeFit, newdata = testingG)
treeProbs <- predict(treeFit, newdata = testingG, type = "prob")

pred <- factor(treeClasses)
truth <- factor(testingG$class)

caret::confusionMatrix(pred, truth)

## C5 66 per cent boruta
#grid <- expand.grid(.model = "tree", .trials = c(1:100),.winnow = FALSE)
c50Grid <- expand.grid(.trials = c(1:9, (1:10)*10),
                       .model = c("tree", "rules"),
                       .winnow = c(TRUE, FALSE))
set.seed(1) 
#bstTree <- train(class ~ ., data = trainingG, method = "C5.0")
c5Fit <- train(class~., data=trainingG, method = "C5.0",tuneGrid = c50Grid,trControl = ctrl,  metric = "Accuracy", importance=TRUE,preProc = c("center", "scale")) 
c5Pred <- predict(bstTree, testingG)
##tuned <- train(trainingG[,1:7], trainingG$class,method = "C5.0", tuneLength = 1,
##trControl = trainControl(method = "repeatedcv",repeats = 5))


pred <- factor(c5Pred)
truth <- factor(testingG$class)

caret::confusionMatrix(pred, truth)

## Fit the model
## Fraud
##partial least squares discriminant analysis

#plsFit <- train(ReportType ~ ., data = trainingG, method = "pls", tuneLength = 15, trControl = ctrl, metric = "ROC", preProc = c("center", "scale"))
## more comprehensive tuning paprametrs than above

ctrl <- trainControl(method = "repeatedcv",
                      repeats = 3,
                      classProbs = TRUE,
                      summaryFunction = twoClassSummary)

plsFit <- train(class ~ .,
                   data = trainingG,
                   method = "pls",
                   tuneLength = 15,
                   trControl = ctrl,
                   metric = "ROC",
                   preProc = c("center", "scale"))


plsClasses <- predict(plsFit, newdata = testingG)
plsProbs <- predict(plsFit, newdata = testingG, type = "prob")

pred <- factor(plsClasses)
truth <- factor(testingG$class)

caret::confusionMatrix(pred, truth)


##Regularized Discriminant Analysis  60 percent withratios
## To illustrate, a custom grid is used
##rdaGrid = data.frame(gamma = (0:4)/4, lambda = 3/4)
set.seed(823)
rdaFit <- train(class ~ ., data = trainingG, method = "rda", trControl = bootcontrol, metric = "ROC")
rdaClasses <- predict(rdaFit, newdata = testingG)
caret::confusionMatrix(rdaClasses, testingG$class)

## knn 60 percent ratios 76 fstrainX <- trainingG[,names(trainingG) != "Direction"]
##preProcValues <- preProcess(x = trainX,method = c("center", "scale"))
set.seed(400)
cv_opts = trainControl(method="cv", number=10)
knn_opts = data.frame(.k=c(seq(3, 11, 2), 25, 51)) #odd to avoid ties
results_knn = train(class ~ ., data = trainingG, method="knn",
                    preProcess="range", trControl=cv_opts,
                    tuneGrid = knn_opts)
 
##ctrlK <- trainControl(method="repeatedcv",repeats = 3) 
##knnFit <- train(class ~ ., data = trainingG, method = "knn", trControl = ctrlK, preProcess = c("center","scale"), tuneLength = 20)

knnClassess <- predict(results_knn, newdata = testingG)
plsprobS <-predict(results_knn, data3[,testingG], type = "prob")
pred <- factor(knnClassess)
truth <- factor(testingG$class)
caret::confusionMatrix(pred, truth)



