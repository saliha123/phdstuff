##svm attribute evaluator with ranker
##WEka
###Unigrams
##ensure results are repeatable
set.seed(7)
library(mlbench)
library(caret)
libs <- c("tm", "plyr", "class")
library(MASS)
library(kernlab)
library(e1071)
library(gbm)
library(dplyr)
library(glmnet)
library(maxent)
library(xlsx)



set.seed(7)
sa_ctrl <- safsControl(functions = rfSA,
                       method = "repeatedcv",
                       repeats = 5,
                       verbose=TRUE, allowParallel=TRUE)


rf_saCOH <- safs(x = dat1, y = classC,
              iters = 100,
              safsControl = sa_ctrl)
rf_saCOH

