library(caret)

library(e1071)


inTrainingG <- createDataPartition(data3$class, p = .75, list = FALSE)
trainingG <- data3[ inTrainingG,]
testingG  <- data3[-inTrainingG,]


ctrlnb = trainControl(method="repeatedcv", number=10, repeats=3,summaryFunction = twoClassSummary,  savePredictions = T, preProc = c("center", "scale"),  classProbs = TRUE)

##Naive Bayes  66 per cent  79 oer cent with boruta 50 per cent with ratios


train_control <- trainControl(method="cv", number=10)

#create model
fit <- train(trainingG[, 1:50], trainingG[, 51], method = "nb",trControl=train_control, laplace = 1)




train_control <- trainControl(method="repeatedcv", number=10, repeats=3, classProbs = TRUE)
nb1 <- train(class ~ ., data=trainingG, method='nb', trControl=train_control, metric="ROC")
# make predictions
nbpred <- predict(fit, testingG)
# summarize results

truth <- factor(testingG$class)
caret::confusionMatrix(nbpred, truth)



varImp(nb)


train_control <- trainControl(method="cv", number=10)

#create model
fit <- train(trainingG[, -class], trainingG[, class], method = "nb",trControl=train_control)








fit1 <- naiveBayes(data3, data3$class, type="raw")
pred1 <- predict(fit1, data3, type="class")
confusionMatrix(pred1, data3$class)

x<-data3

x[x[,"zeroVar"] + x[,"nzv"] > 0, ] 
