##ensure results are repeatable
set.seed(7)
library(mlbench)
library(caret)
library(MASS)
library(kernlab)
library(e1071)
library(gbm)
library(dplyr)
library(glmnet)
library(maxent)
library(xlsx)
libs <- c("tm", "plyr", "class")
lapply(libs, require, character.only = TRUE)

tdm.stack$ReportType <- NULL
RepT <- c(rep("nf", times = 50),rep("f", times = 50))
classT<- factor(RepT)
tdm.stack <- cbind(tdm.stack,classT )
data3 <- cbind(unigrams_import, classT)


#prepare the data
control5<-trainControl(method="repeatedcv", number=10, repeats=3, verbose=TRUE, allowParallel=TRUE)
#train the model
model<-train(class ~ ., data = data3t, method="lvq", preProcess="scale", trControl=control5)
#estimate variable importance
model<-train(class ~ ., data = data3t, method="svmRadial", preProcess="scale", trControl=control5)

importance <- varImp(model, scale=FALSE)
#summarise importance
print(importance)
plot(importance)

## Univariate filters

data3$class <- NULL
data3$RepType <-NULL

dat1 <-tdm.stack
RepT <-tdm.stack$classT
dat1$classT <- NULL


filterCtrl <- sbfControl(functions = rfSBF,
                         method = "repeatedcv", repeats = 5)

set.seed(10)
rfWithFilter <- sbf(dat1, RepT, sbfControl = filterCtrl)
rfWithFilter

## LIWC/coh for filters

filter2 <- c("TextEasaPCTemp", "CausalVerbs", "LIWCInsight", "NumModPerNounPhrase", "TextEasaPCRfCoh")
filter1 <- c("accelerate","accommodate", "accompanying", "accuracy", "achieving")

data3 <- subset(tdm.stack, select = c(filter1, "classT"))
data3 <- subset(data1, select = c(filter2,"class"))



# simulate annealing

dat1 <- data1
dat1$class <- NULL
class <- data1$class

dat1 <-tdm.stack
dat1$classT <- NULL
class <-tdm.stack$classT

dat1 <-sdfoT
sdfoTS$class <- NULL
set.seed(7)
sa_ctrl <- safsControl(functions = rfSA,
                       method = "repeatedcv",
                       repeats = 5,
                       improve = 50,verbose=TRUE, allowParallel=TRUE)

rf_saR <- safs(x = dat1, y = classR,
              iters = 100,
              safsControl = sa_ctrl)
rf_saR




## build up df for app 1 unigrams
dat1 <- tdm.stack
data3 <- subset(tdm.stack, select = c(top32_uni1))
data3$ReportType<- NULL
data3<-cbind(data3, class)





data3 <- subset(dat1, select = c(fiveUni5))
data3 <-cbind(data3, class)
data3 <- subset(dat1, select = c(temp2))
data3 <-cbind(data3, class)


colnames(data3)[33] <- "class"



data3 <- subset(sdfoB, select = c(bigrams_sa33))
data3 <- cbind(data3, class)


top five ratios

ratios_sa <- c("Imagery", "Average.Sentence.Length", "Average.Word.Length", "Content.Word.Diversity", "Function.Word.Diversity", "class")

data3 <- subset(data3, select = c(ratios_sa))
