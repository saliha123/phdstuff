library(caret)
library(mlbench)
data(Sonar)
Sonar <- as.data.frame(Sonar)
set.seed(107)
inTrain2 <- createDataPartition(y = Sonar$Class,  p = .75,list = FALSE)

training2 <- Sonar[ inTrain2,]
testing2 <- Sonar[-inTrain2,]



ctrl2 <- trainControl(method = "repeatedcv",repeats = 3, classProbs = TRUE,summaryFunction = twoClassSummary)
plsFit2 <- train(class ~ ., data = training2, method = "pls", tuneLength = 15, trControl = ctrl, metric = "ROC",preProc = c("center", "scale"))


