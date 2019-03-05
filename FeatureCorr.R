#ensure that the results are repeatable
set.seed(7)
#load the library
library(mlbench)
library(caret)
data8 <- read.csv(file=file.path("C:","data5", "MatOrigCsvV1.csv"))
data9 <- data.frame(data8)

dart2 <- data1
dart2$class <-NULL
#load the data
#data(data2)
#Calculate the correlation matrix
CorMatrix <-cor(dat1)
##print the Correlation MAtrix
print(CorMatrix)
##Highly correlated
highlyCor <- findCorrelation(CorMatrix, cutoff = 0.90)
#print indexes of highly correlated attributes
##td1 <- data9[, -highlyCor]
HCorr1 <- dat1[, -highlyCor]
class <- data1$class
data3 <- cbind(HCorr1, class)
print(highlyCor)






