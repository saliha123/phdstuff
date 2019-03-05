library(caret)
library(mvtnorm)

#set.seed(998)

inTrainingG <- createDataPartition(data3$class, p = .75, list = FALSE)
trainingG <- data3[ inTrainingG,]
testingG  <- data3[-inTrainingG,]

#set.seed(400)

ctrl = trainControl(method="repeatedcv", number=10, repeats=3,summaryFunction = twoClassSummary, classProbs = TRUE)
knn_opts = data.frame(.k=c(seq(3, 11, 2), 25, 51)) #odd to avoid ties


results_knn = train(class ~ ., data = trainingG, method="knn",
                    preProcess="range", 
                    trControl = ctrl,
                    metric="ROC")
                    tuneGrid = knn_opts 

knnClassess <- predict(results_knn, newdata = testingG)
pred <- factor(knnClassess)

truth <- factor(testingG$class)

caret::confusionMatrix(pred, truth)


varImp(results_knn)


bestknn<-results_knn
results_knn<-bestknn
