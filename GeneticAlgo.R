library(caret)
library(mlbench)
library(MASS)

ga_ctrl <- gafsControl(functions = rfGA, method = "repeatedcv",repeats = 5, verbose = TRUE,  allowParallel = TRUE)

## Use the same random number seed as the RFE process
## so that the same CV folds are used for the external
## resampling.

set.seed(10)


rf_ga <- gafs(x = data3, y = RepType, iters = 50, gafsControl = ga_ctrl)
              
rf_ga

cvIndex <- createMultiFolds(training$class, times = 2)
ctrl <- trainControl(method = "repeatedcv", repeats = 2, classProbs = TRUE,summaryFunction = twoClassSummary, allowParallel = FALSE,index = cvIndex)


## 'ind' will be a vector of 0/1 data denoting which predictors are being
## evaluated.
ROCcv <- function(ind, x, y, cntrl) {
library(caret)
library(MASS)
ind <- which(ind == 1)
## In case no predictors are selected:
if (length(ind) == 0) return(0)
out <- train(x[, ind, drop = FALSE], y,method = "qda",metric = "ROC",trControl = cntrl) 

## this function returns the resampled ROC estimate
##caret:::getTrainPerf(out)[, "TrainROC"]

  library(GA)
  set.seed(137)
  ga_resampled <- ga(type = "binary", 
                     fitness = ROCcv, 
                     min = 0, 
                     max = 1, 
                     maxiter = 400, 
                     nBits = ncol(training) - 1, 
                     names = names(training)[-ncol(training)], 
                     ## These options are passed through the ga funciton
                     ## and into the ROCcv function
                     x = training[, -ncol(training)], 
                     y = training$class, 
                     cntrl = ctrl, 
                     ## These two options are not yet in the GA package.
                     keepBest = TRUE, 
                     parallel = TRUE)
