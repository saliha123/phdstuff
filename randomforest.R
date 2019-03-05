library(caret)
library(mvtnorm)
library(pscl)


## random forest accuracy 70 percent boruta 76 per cent with ratios  84 

#set.seed(998)

inTrainingG <- createDataPartition(data3$class, p = .75, list = FALSE)
trainingG <- data3[ inTrainingG,]
testingG  <- data3[-inTrainingG,]


control <- trainControl(method="repeatedcv", number=10, repeats=3, classProbs = TRUE, summaryFunction = twoClassSummary)
metric <- "ROC"
mtry <- 13
tunegrid <- expand.grid(.mtry=mtry)
trf <- train(class~., data=trainingG, method="rf", metric=metric, trControl=control, tuneGrid = tunegrid)


trfclasses <- predict(trf, newdata = testingG)
trfProbs <- predict(trf, newdata = testingG, type = "prob")

pred <- factor(trfclasses)
truth <- factor(testingG$class)

caret::confusionMatrix(pred, truth)


varImp(trf)




bestresult_rf<-trf

trf<-bestresult_rf




metric <- "kappa"
control <- trainControl(method="repeatedcv", number=10, repeats=3, search="grid")
tunegrid <- expand.grid(.mtry=c(1:15))
rf_gridsearch <- train(class~., data=trainingG, method="rf", metric=metric, tuneGrid=tunegrid, trControl=control)
print(rf_gridsearch)
plot(rf_gridsearch)





