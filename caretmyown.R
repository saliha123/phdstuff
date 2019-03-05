library(caret)
library(mlbench)
mydata = read.csv("C:/temp/mat3.csv") 
mydata <- as.data.frame(mydata, stringsASFactors = TRUE)                        
set.seed(107)
inTrain1 <- createDataPartition(y = mydata$Class,  p = .75,list = FALSE)
training <- mydata[ inTrain1,]
testing <- mydata[-inTrain1,]


ctrl <- trainControl(method = "repeatedcv",repeats = 3, classProbs = TRUE,summaryFunction = twoClassSummary)
plsFit <- train(Class ~ ., data = training, method = "pls", tuneLength = 15, trControl = ctrl, metric = "ROC",preProc = c("center", "scale"))

plsProbs <- predict(plsFit, newdata = testing, type = "prob")

##confusionMatrix(data = plsProbs, testing[87])


## To illustrate, a custom grid is used
##rdaGrid = data.frame(gamma = (0:4)/4, lambda = 3/4)
##set.seed(123)
##rdaFit <- train(Class ~ ., data = training, method = "rda",tuneGrid = rdaGrid, trControl = ctrl, metric = "ROC")







