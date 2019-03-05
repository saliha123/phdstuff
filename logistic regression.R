library(caret)
library(mvtnorm)
library(pscl)

#set.seed(998)

inTrainingG <- createDataPartition(data3$class, p = .75, list = FALSE)
trainingG <- data3[ inTrainingG,]
testingG  <- data3[-inTrainingG,]

##  accuracy 50 percent  Boosted Logistic Regression   70 percent  70 per cent with boruta  84 with ratios

ctrl <- trainControl(method = "repeatedcv", number = 10, repeats = 3, classProbs = TRUE,summaryFunction = twoClassSummary)

#set seed(825)
blrFit2 <- train(class ~ ., data = trainingG,
                 #method = "glm",
                 method = "LogitBoost",
                 trControl = ctrl,
                 verbose = FALSE,
                 preProc=c("center", "scale"),
                 ## Now specify the exact models 
                 ## to evaludate:
                 metric = "ROC")

predlr <- predict(blrFit2, newdata = testingG)

predlr <- factor(predlr)
truthlr <- factor(testingG$class)
caret::confusionMatrix(predlr, truthlr)



varImp(blrFit2)

bl<-blrFit2
