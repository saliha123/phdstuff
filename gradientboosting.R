library(caret)
library(mvtnorm)
library(pscl)

#set.seed(998)

inTrainingG <- createDataPartition(data3$class, p = .75, list = FALSE)
trainingG <- data3[ inTrainingG,]
testingG  <- data3[-inTrainingG,]


#gbmGrid <- expand.grid(n.trees = 50, interaction.depth = 10, shrinkage = 0.1, n.minobsinnode = 10) 

gbmGrid <-  expand.grid(interaction.depth = 10,
                        n.trees = 150,
                        shrinkage = 0.1,
                        n.minobsinnode = 10)



#gbmGrid <- expand.grid(n.trees = 200, interaction.depth = 10, shrinkage = 0.1, n.minobsinnode = 10) 




ctrl <- trainControl(method = "repeatedcv", number = 10, repeats = 3,classProbs = TRUE,summaryFunction = twoClassSummary )
gbmFit <- train(class ~ ., data = trainingG, method = "gbm", trControl = ctrl, verbose = FALSE, metric = "ROC",tuneGrid = gbmGrid)
gbmFit 

testingG<- testingG[complete.cases(testingG),]
gbmClasses <- predict(gbmFit, newdata = testingG)
gbmProbs <- predict(gbmFit, newdata = testingG)

pred <- factor(gbmClasses)
truth <- factor(testingG$class)

caret::confusionMatrix(pred, truth)

varImp(gbmFit)



whichTwoPct <- tolerance(gbmFit$results, metric = "ROC",
                         tol = 2, maximize = TRUE)
cat("best model within 2 pct of best:\n")


gbmFit$results[whichTwoPct,1:6]