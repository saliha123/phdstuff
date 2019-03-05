#init
libs <- c("tm", "plyr", "class")
library(MASS)
library(kernlab)
library(e1071)
library(gbm)
library(dplyr)
library(glmnet)
library(maxent)
library(xlsx)

lapply(libs, require, character.only = TRUE)

# set options

data2 <- read.csv(file=file.path("C:","data6", "matrixOrigcsv.csv"))
data3 <- as.data.frame(data1,  stringsASFactors = FALSE)
set.seed(80)

data1 <- read.csv(file=file.path("C:","data6", "Ratios2r.csv"))
data3 <- as.data.frame(data1,  stringsASFactors = FALSE)
set.seed(80)

tdm.stack$ReportType <- NULL
RepT <- c(rep("nf", times = 50),rep("f", times = 50))
classT<- factor(RepT)
tdm.stack <- cbind(tdm.stack, classT)


data1

## to get z scores
X2 <- data3[1:19]
X2<- as.data.frame (X2)
X2<-apply(X2, 2, scale)

data3$class <- factor(data3$class)
X2 <- cbind(X2, data3$class)

data3 <-subset(data3, select = to_select)

data3 <-subset(data3, select = to_select2)