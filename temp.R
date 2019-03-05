library(tm)
library(SnowballC)
library(ForImp)



n1<-1
while (n1 < 101){
for (w in 1:1876){
if (mdtm[n1, w]==0){
  mdtm[n1,w] <- 0.1
}
}
n1= n1+1
}



## apply KNN using Cosine

mdtm<-tdm.stack
mdtm$classT <-NULL
for (m in 1:50)  {
  rownames(mdtm)[m] = paste("nf",rownames(mdtm)[m] , sep=" ")
}

for (m in 51:100)  {
  rownames(mdtm)[m] = paste("f", rownames(mdtm)[m], sep=" ")
}

mdtm <- mdtm[sample(nrow(mdtm)),]

i  <-1
N  <-100
a<-0
f<-0


#get cos for 99 firms

x <- data.frame(matrix(ncol = 2, nrow = 100))
s <- data.frame(matrix(ncol = 7, nrow = 31))

while (i < 30) {
  for (m in 1:100){
    x[m,1] <- vcosw(mdtm[m], mdtm[i])
    
    ##x[m,1]<- sqrt(sum((mdtm[m]-mdtm[i])^2))
    
    x[m,2] <-  substr(rownames(mdtm[m,]),1,2) 
  }
  
  n<-1
  
  for (t in 1:6)  {
    s[i,t] <- sort(x[,1], TRUE)[n]
    rnum<-which(x[,1] == s[i,t])
    z1 <- x[rnum,2]
    s[i,t]<-paste(z1, s[i,t])
    n<-n+1 
  }
  
  s[i,7]<-substr(rownames(mdtm[i,]),1,2) 
  
  for (b in 2:6)  {
    if (substr(s[i,b],1,2) == s[i,7] ) {
    a <- a + 1
  }
  }
  
  if ((a==3)|(a==4)|(a==5)){
    f<-1 +f
  }
  
  i<-i+1
  a<-0
  
}

message("num correctly assigned ", f)
