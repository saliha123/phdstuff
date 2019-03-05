library("Boruta")
library("mlbench")
set.seed(1)


RepT <- c(rep("f", times = 102),rep("nf", times = 306))
class<- factor(RepT)

tdm.stack <- cbind(tdm.stack, class)

sdfotWSt<-cbind(sdfotWSt, class)
data3<- cbind(data3, class)


data3<-bigrams_408

data3<-sdfotWSt
data3<-data2

data2 <- cbind(data2, class)

Boruta.Fraud2 <- Boruta(classT ~ ., data = data3, doTrace = 2,ntree = 500)
#Boruta.Fraud <- Boruta(RepType ~ ., data = data1, doTrace = 2,ntree = 500)
Boruta.Fraud2 <- Boruta(class ~ ., data = data3, doTrace = 2,ntree = 500)


bor_coh2<-getSelectedAttributes(Boruta.Fraud2, withTentative = FALSE)
bor_coh2
bor_coh<-getSelectedAttributes(Boruta.Fraud2, withTentative = TRUE)

salT <-TentativeRoughFix(Boruta.Fraud2)



