library(stats)
library(caret)
library(mlbench)
library(MASS)

data3<-data2
## feature selection using univariate filters
filterCtrl <- sbfControl(functions = rfSBF, method = "repeatedcv", repeats = 5)
set.seed(10)
rfWithFilter <- sbf(data3[,1:34], data3[,35], sizes=c(1:35), sbfControl=filterCtrl)
rfWithFilter
importance2 <- varImp(rfWithFilter, scale=FALSE)
predictors(rfWithFilter)



nd2<-subset(data3, select = c(predictors(rfWithFilter, "NumModPerNounPhrase", "TextEasaPCRfCoh")))
nd2 <- cbind(nd2, data3["TextEasaPCRfCoh"])
nd2 <- cbind(nd2, data3["NumModPerNounPhrase"])
nd2 <- cbind(nd2, data3["class"])

## simulated annealing
sa_ctrl <- safsControl(functions = rfSA,
                       method = "repeatedcv",
                       repeats = 5,
                       improve = 50)

set.seed(10)
rf_sa <- safs(x = data3[,1:6226], y = data3[,6227], iters = 100, safsControl = sa_ctrl)
rf_sa


library(caret)
library(mlbench)
library(Hmisc)
library(randomForest)

set.seed(10)

ctrl <- rfeControl(functions = lmFuncs,
                   method = "repeatedcv",
                   repeats = 5,
                   verbose = FALSE)

lmProfile <- rfe(data3, class,
                 sizes = subsets,
                 rfeControl = ctrl)

lmProfile




normalization <- preProcess(data3)
x <- predict(normalization, data3)
x <- as.data.frame(x)
subsets <- c(1:5, 10, 15, 20, 25)