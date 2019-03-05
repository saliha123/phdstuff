classnum<-ncol(trainingG)
isshowplane=T
showtune=F


tune<-train(class ~.,data=bor_data,method="nnet",tuneLength=4,maxit=100,trace=F)
  if(showtune)
    print(tune)
  
  res<-nnet(class ~.,bor_data,size=5,decay=0.1)
  
  print(table(as.numeric(bor_data$class)-1,round(predict(res,bor_data[,-classnum]))))
  
  if(isshowplane){
    range<-c(-3,3)
    px<-seq(range[1],range[2],0.03)
    py<-px
    
    grid<-expand.grid(px,py)
    names(grid)<-c("x","y")
    out.predict<-predict(res,grid,type="raw")
    d1<-d[which(d[,3]==1),-labelnum]
    d2<-d[which(d[,3]==2),-labelnum]
    plot(  d1,col="blue",pch=19,cex=3,xlim=range,ylim=range)
    points(d2,col="red",pch=19,cex=3)
    
    par(new=T)
    contour(px,py,
            array(out.predict,dim=c(length(px),length(py))),
            xlim=range,ylim=range,
            col="purple",lwd=3,drawlabels=F,levels=0.5)
  }
  
}

## 2nd attemp

#Load Packages
require(nnet)
require(caret)


#Fit model
model <- train(ReportType ~., data=tdm_newR, method="nnet", linout=TRUE, trace = FALSE,
               #Grid of tuning parameters to try:
               tuneGrid=expand.grid(.size=c(1,5,10),.decay=c(0,0.001,0.1))) 

te <- data.frame(tdm_newR$ReportType)
ps <- predict(model, te)


res<-nnet(ReportType ~.,tdm_newR,size=5,decay=0.1)
print(table(as.numeric(tdm_newR$ReportType)-1,round(predict(res,tdm_newR[,-classnum]))))






my.grid <- expand.grid(.decay = c(0.5, 0.1), .size = c(5, 6, 7))
prestige.fit <- train(ReportType ~., data = trainingG, method = "nnet", maxit = 1000, tuneGrid = my.grid, trace = F, linout = 0)   

prestige.predict <- predict(prestige.fit, newdata = testingG)
prestige.rmse <- sqrt(mean((prestige.predict - testingG$ReportType)^2)) 

confusionMatrix(prestige.predict, testingG$ReportType)

