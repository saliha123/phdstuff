library('proxy') 

tdm.stack2<-tdm.stack
tdm.stack2 <- tdm.stack2[sample(nrow(tdm.stack2)),]
z1<-tdm.stack2$classT
tdm.stack2$classT <-NULL


classK <- rep(0, times=100)
  
  
for (m in 1:100) { 
  if (z1[m]=="f"){
    classT[m]<-1
   }else{
     classT[m]<-0
  }
}

for (m in 1:50) { 
  
    classK[m]<-2
 
  }




tdm.stack2<-cbind(tdm.stack2, classT)


k.nearest.neighbors <- function(i, distance.matrix, k = 5)
{
  ordered.neighbors <- order(distance.matrix[i, ]) 
  # This just gives us the list of points that are
  # closest to row i in descending order.
  
  # The first entry is always 0 (the closest point is the point itself) so 
  # let's ignore that entry and return points 2:(k+1) instead of 1:k
  return(ordered.neighbors[2:(k + 1)])
}

##practice run of above algo
k.nearest.neighbors(6, b, 5)

# Wow, it's just that simple.  OK, so if we wanted to classify *all* of
# our points according to kNN (pretending we don't know what they are),
# how would we do?
knn <- function(df, k = 3)
{
  distance <- as.matrix(dist(df[1:100,1:1876], method="cosine"))
  predictions <- rep(0, nrow(df))
  
  # For every point in the dataset
  for (i in 1:nrow(df))
  {
    indices <- k.nearest.neighbors(i, distance, k = 5)  # Get the nearest neighbors
    predictions[i] <- ifelse(mean(df[indices, 'classT']) > 0.5, 1, 0)  # Have them vote on their label.  
    # If > 0.5, then this is in class "1"
  }
  return(predictions)
}

## only get predictions for test set_____________________


knn2 <- function(df)
{
 d <- as.matrix(dist(df[1:100,1:1876], method="cosine"))
  predictions <- rep(0, nrow(df))

 # For every point in the dataset
for (i in 1:nrow(df))
{
  indices <- k.nearest.neighbors(i, d, k = 5)  # Get the nearest neighbors
  predictions[i] <- ifelse(mean(df[indices, 'classT']) > 0.5, 1, 0)  # Have them vote on their label.  
  # If > 0.5, then this is in class "1"
}
return(predictions)
}


tdm.test <-tdm.stack2[1:30,]
predictions <- knn2(tdm.test)

tdm.test$predictions <- predictions
sum(tdm.test$classT != tdm.test$predictions)

table("Predictions" = tdm.test$predictions, Actual=tdm.test$classT)


# So let's use 5 NN to make our predictions...
predictions <- knn(tdm.stack2, 5)

tdm.stack2$predictions <- predictions
sum(tdm.stack2$classT != tdm.stack2$predictions)

table("Predictions" = tdm.stack2$predictions, Actual =tdm.stack2$classT)


d <- dist(mdtm, method="cosine")
b <- as.matrix(d)


cosineDist <- function(x){
  as.dist(1 - x%*%t(x)/(sqrt(rowSums(x^2) %*% t(rowSums(x^2))))) 
}

