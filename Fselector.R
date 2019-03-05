library("FSelector")
library("caret")



data3<-data2
weights <- information.gain(class~., data3)
print(weights)
subset <- cutoff.k(weights, 20)
w2 <-weights[order(-weights$attr_importance), , drop = FALSE]
head(w2,100)


weights <- gain.ratio(class~., data3)
print(weights)
subset <- cutoff.k(weights, 2)
f1 <- as.simple.formula(subset, "class")
print(f1)

weights <- symmetrical.uncertainty(class~., data3)
print(weights)
subset <- cutoff.biggest.diff(weights)
f1 <- as.simple.formula(subset, "class")
print(f1)

## use the relief method

weights <- relief(class~., data3, neighbours.count = 5, sample.size = 20)
subset <- cutoff.k(weights, 2)
f <- as.simple.formula(subset, "class")

newdata <-  data3[,cutoff.k(weights, 2)] 


library(mlbench)


weights2 <- chi.squared(class~., data3)
print(weights2)
subset <- cutoff.k(weights2, 20)
f2 <- as.simple.formula(subset, "class")
print(f2)

w2 <-weights2[order(-weights2$attr_importance), , drop = FALSE]
head(w2,100)


