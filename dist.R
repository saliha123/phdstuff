library(tm)
library(SnowballC)
library(ForImp)

tdm.stack2<-tdm.stack
tdm.stack2$classT <- NULL

m<-51
n<-52
o<-1


r1 <- data.frame(matrix(ncol = 2, nrow = 50))


while (m<101){

##r1[o,1]<-sqrt(sum((tdm.stack2[m,]-tdm.stack2[n,])^2))
r1[o,1] <-vcosw(tdm.stack2[m,],tdm.stack2[n,])
r1[o,2] <-"f"
m<-m+2
n<-n+2
o<-o+1
}

m<-1
n<-2
o<-26

while (m<51)  {
  ##r1[o,1]<-sqrt(sum((tdm.stack2[m,]-tdm.stack2[n,])^2))
  r1[o,1] <-vcosw(tdm.stack2[m,],tdm.stack2[n,])
  r1[o,2] <-"nf"
  m<-m+2
  n<-n+2
  o<-o+1
}

