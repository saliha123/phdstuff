library(Matrix)
library(irlba)

MyData <- read.csv(file= "C:/data6/wa/concepts/concepts204.csv", header=TRUE, sep=",")

MyData <- read.csv(file= "C:/data6/wa/concepts/Final Concepts 408_matrixv2csv.csv", header=TRUE, sep=",")


class <-MyData$class
data2<-MyData
data2$class <-NULL
data2[1]<-NULL



data2 = data2[,colSums(data2) > 0]
b<-colSums(data2 != 0)


a <-c()
count <-1

for(i in 1:length(b)) { 
  if(b[i] > 5 ) {
    t1 <-names(b[i])
    a[count]= c(t1)
    count =count +1
    }
}

data2 <- subset(data2, select = (a))

## reafdy for classifer add labels

data3<-data2

## remove all columns wil zeros

x <- data2
data2 <-x[,which(!apply(x,2,FUN = function(x){all(x == 0)}))]

data2<-as.data.frame(data2)
data2 <- cbind(data2, class)

## ready to pass to classifersi
data3 <- data2


RepT <- c(rep("f", times = 102),rep("nf", times = 306))
class<- factor(RepT)

data3<- data2

data3 <- cbind(data3, class)
