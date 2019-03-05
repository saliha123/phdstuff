library(maxent)
#data <- read.csv(system.file("C:/Users/SalihaMinhas/Downloads/NYTimes.csv.gz", package="maxent"))



Tsample <- tdm.stack[train.idx,][,-1607]
RepType <- tdm.stack[train.idx,][,1607]
TestSample <- tdm.stack[test.idx,][,-1607]
RepType2 <-tdm.stack[test.idx,][,1607]

maxmodel <- maxent(Tsample, RepType)


results <- predict(maxmodel, TestSample, type = 'response' )
x <- as.numeric(results[,1])

tab <- table(pred = x, true = RepType2)

