library(mlbench)
library(caret)

library(caret)
library(mlbench)
data(Sonar)
set.seed(808)
inTrain <- createDataPartition(Sonar$Class, p = 2/3, list = FALSE)
## Save the predictors and class in different objects
sonarTrain <- Sonar[ inTrain, -ncol(Sonar)]
sonarTest  <- Sonar[-inTrain, -ncol(Sonar)]

trainClass <- Sonar[ inTrain, "Class"]
testClass  <- Sonar[-inTrain, "Class"]

centerScale <- preProcess(sonarTrain)
centerScale

trainingS <- predict(centerScale, sonarTrain)
testingS <- predict(centerScale, sonarTest)

knnFitS <- knn3(trainingS, trainClass, k = 11)
knnFitS
plsClassesS <- predict(knnFitS, newdata = testingS)
str(plsClassesS)
plsprobS <-predict(knnFitS, head(testingS), type = "prob")
head(plsprobS)

confusionMatrix(data = plsClassesS, testingS$Class)
