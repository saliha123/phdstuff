#ensure results are repeatable
set.seed(7)
library(mlbench)
library(caret)
#load the data
#define the control using random forest selection function
control<-rfeControl(functions=rfFuncs, method="cv", number=10 )
#control<-rfeControl(functions=caretFuncs, number=200, method="svmRadial")

#run the RFE algorithm
results <- rfe(data3[,1:86], data3[,87],sizes=c(1:86), rfeControl=control)
#results <- rfe(data3[,1:20], data3[,21],sizes=c(1:20), rfeControl=control)

#summarise the results
print(results)
#list the chosen predictors
predictors(results)
#plot the results
plot(results, type=c("f", "nf"))

dat2<- subset(data3, select=c("Pleasantness", "Affect", "Content.Word.Diversity", "Average.Sentence.Length", "Function.Word.Diversity","class"))


