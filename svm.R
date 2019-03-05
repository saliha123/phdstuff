library(caret)
library(mvtnorm)
library(pscl)


inTrainingG <- createDataPartition(data3$class, p = .75, list = FALSE)
trainingG <- data3[ inTrainingG,]
testingG  <- data3[-inTrainingG,]

## Svm
#set.seed(825)

svmGrid <-  expand.grid(sigma=0.5, C=4)


fitControl <- trainControl(method = "repeatedcv",
                           number = 10,
                           repeats = 3,
                           summaryFunction = twoClassSummary,
                           classProbs = TRUE)


ctrl <- trainControl(method = "cv", savePred=T, classProb=T)

svmFit <- train(class~., data = trainingG,
                method = "svmRadial",
                trControl = fitControl,
                #tuneGrid = svmGrid,
                preProc = c("center", "scale"),
                tuneLength = 8,
                metric = "ROC")


#testingG<- testingG[complete.cases(testingG),]

predsv <- predict(svmFit, newdata = testingG)
predsv

predsv <- factor(predsv)
truthsv <- factor(testingG$class)

caret::confusionMatrix(predsv, truthsv)


varImp(svmFit)

bestcasesvm <-svmFit
svmFit<-bestcasesvm
