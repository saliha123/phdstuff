library(caret)
library(devtools)
library(mvtnorm)
library(pscl)
library(ISLR)

resamps <- resamples(list(LogitBoost = blrFit2, knn = results_knn, svmRadial = svmFit, rf = trf, gbm = gbmFit))



summary(resamps)

trellis.par.set(theme)
bwplot(resamps, layout = c(3,1))

trellis.par.set(caretTheme())
dotplot(resamps, metric = "ROC")

splom(resamps)


difvalues <- diff(resamps)
summary(difvalues)

trellis.par.set(theme)
bwplot(difvalues, layout = c(3,1))

trellis.par.set(caretTheme())
dotplot(difvalues)



seed<-7
metric <- "Accuracy"
control <- trainControl(method="repeatedcv", number=10, repeats=3, search="grid")
tunegrid <- expand.grid(.mtry=c(sqrt(8)))
modellist <- list()
for (ntree in c(1000, 1500, 2000, 2500)) {
  set.seed(7)
  fit <- train(class~., data=data3, method="rf", metric=metric, tuneGrid=tunegrid, trControl=control, ntree=ntree)
  key <- toString(ntree)
  modellist[[key]] <- fit
}
# compare results
results <- resamples(modellist)
summary(results)
dotplot(results)



control <- trainControl(method="repeatedcv", number=10, repeats=3, search="random")
set.seed(seed)
mtry <- sqrt(7)
rf_random <- train(class~., data=data3, method="rf", metric=metric, tuneLength=15, trControl=control)
print(rf_random)
plot(rf_random)





