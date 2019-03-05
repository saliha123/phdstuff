library(caret)
library(devtools)
library(mvtnorm)
set.seed(998)

inTrainingG <- createDataPartition(data3$class, p = .75, list = FALSE)
trainingG <- data3[ inTrainingG,]
testingG  <- data3[-inTrainingG,]

folds=5
repeats=5
myControl <- trainControl(method='cv', number=folds, repeats=repeats, 
                          returnResamp='none', classProbs=TRUE,
                          returnData=FALSE, savePredictions=TRUE, 
                          verboseIter=TRUE, allowParallel=TRUE,
                          summaryFunction=twoClassSummary,
                          index=createMultiFolds(trainingG$class, k=folds, times=repeats))
PP <- c('center', 'scale')



## boosted tree 50 per cent on boruta  60 percent on ratios

model2 <- train(class ~ ., data = trainingG, method='blackboost', trControl=myControl)
Classes2 <- predict(model2, newdata = testingG)
Probs2 <- predict(model2, newdata = testingG, type = "prob")
caret::confusionMatrix(data = Classes2, testingG$class)

### Multi layer perceptron accuracy about 70 percent 50 percent withratios  64 good with coh metrix
model4 <- train(class ~ ., data = trainingG, method='mlpWeightDecay', trControl=myControl, trace=FALSE, preProcess=PP)
Classes4 <- predict(model4, newdata = testingG)
Probs4 <- predict(model4, newdata = testingG, type = "prob")
caret::confusionMatrix(Classes4, testingG$class)

## Multivariate Adaptive Regression Spline  66 per cent 50percent with ratios
model6 <- train(class ~ ., data = trainingG, method='earth', trControl=myControl, preProcess=PP)
Classes6 <- predict(model6, newdata = testingG)
Probs4 <- predict(model6, newdata = testingG, type = "prob")
caret::confusionMatrix(Classes6, testingG$class)

##Generalized Linear Model  66 percent 50 per cent ratios  64

model7 <- train(class ~ ., data = trainingG, method='glm', trControl=myControl, preProcess=PP,  metric = "ROC")
Classes7 <- predict(model7, newdata = testingG)

pred <- factor(Classes7)
truth <- factor(testingG$class)

caret::confusionMatrix(pred, truth)


#model9 <- train(train$good ~ ., data = trainingG, method='gam', trControl=myControl, preProcess=PP)
model9 <- train(trainingG$class, method='gam', trControl=myControl, preProcess=PP)

## ada   accuracy 50 percent  Booseted classification trees accuracy  70 per cent  76 per cent ratios 80 75 with coh on SA
adaT <- trainingG[!colnames(trainingG) %in% "class"]
adaTrainC <- as.factor(trainingG$class)

## Boosted classification treees
results_ada = train(x = adaT, y = adaTrainC, method="ada")
Classes8 <- predict(results_ada, newdata = testingG)
caret::confusionMatrix(Classes8,testingG$class)

##  accuracy 50 percent  Boosted Logistic Regression   70 percent  70 per cent with boruta  84 with ratios
cvIndex <- createMultiFolds(trainingG$class, times = 10)
ctrl <- trainControl(method = "repeatedcv", repeats = 10, classProbs = TRUE,summaryFunction = twoClassSummary, allowParallel = FALSE,index = cvIndex)
tg <- expand.grid(nIter=20)

set.seed(825)
blrFit2 <- train(class ~ ., data = trainingG,
                 #method = "glm",
                 method = "LogitBoost",
                 trControl = ctrl,
                 verbose = FALSE,
                 ## Now specify the exact models 
                 ## to evaludate:
                  metric = "ROC")

Classes9 <- predict(blrFit2, newdata = testingG)

pred <- factor(Classes9)
truth <- factor(testingG$class)

caret::confusionMatrix(pred, truth)

##Naive Bayes  66 per cent  79 oer cent with boruta 50 per cent with ratios
tn =  data.frame(fL = TRUE, usekernal = TRUE)

ctrl <- trainControl(method = "repeatedcv", repeats = 10, classProbs = TRUE,summaryFunction = twoClassSummary)

model10 <- train(class~., data=trainingG, trControl=ctrl, method="nb", metric='ROC')
# make predictions
Classes10 <- predict(model10, testingG)
# summarize results

pred <- factor(Classes10)
truth <- factor(testingG$class)

caret::confusionMatrix(pred, truth)


## Svm
set.seed(825)
fitControl <- trainControl(method = "repeatedcv",
                           number = 10,
                           repeats = 10,
                           ## Estimate class probabilities
                           classProbs = TRUE,
                           ## Evaluate performance using 
                           ## the following function
                           summaryFunction = twoClassSummary)


svmFit <- train(class~., data = trainingG,
                method = "svmRadial",
                trControl = fitControl,
                preProc = c("center", "scale"),
                tuneLength = 8,
                metric = "ROC")

testingG<- testingG[complete.cases(testingG),]
svmClass <- predict(svmFit, testingG)

pred <- factor(svmClass)
truth <- factor(testingG$class)


table (pred, truth)
caret::confusionMatrix(pred, truth)
