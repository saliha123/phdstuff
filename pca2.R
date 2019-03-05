library("factoextra")
library("FactoMineR")

## for bag of words
data2 <-tdm.stack
data2$ReportType <- NULL
data2$classT <- NULL

## for n grams
data2<-sdfotWSt
class <-MyData$class
data2$class <-NULL
data2[1]<-NULL

## for Coh Metrix
## 204
data2 <- read.csv(file="C:/data6/wa/Coh_Metrix/cohmetrix204v4.csv", header=TRUE, sep=",")
## 408
data2 <- read.csv(file="C:/data6/wa/Coh_Metrix/cohwholecsvall.csv", header=TRUE, sep=",")


# LIWC

data2 <- read.csv(file="C:/data6/new LIWC results/LIWCCSVALL.csv", header=TRUE, sep=",")


data2$Filename <-NULL
data2$class<-NULL


#Dictionaries
data2 <- read.csv(file="C:/data6/wa/Dictionaries/L&M Sentimentsv8csv.csv", header=TRUE, sep=",")


# topics
data2 <- read.csv(file="C:/data6/wa/topicmallet/topicscsvall.csv", header=TRUE, sep=",")


#ratios
data2 <- read.csv(file="C:/data6/wa/LBC/ratios_csv_V4.csv", header=TRUE, sep=",")


#concepts
data2 <- read.csv(file="C:/data6/wa/concepts/Final Concepts 204_matrix.csv", header=TRUE, sep=",")

data2 <- read.csv(file="C:/data6/wa/concepts/MyDatacon204.csv", header=TRUE, sep=",")
data2 <- read.csv(file="C:/data6/wa/concepts/Final Concepts 408_matrix.csv", header=TRUE, sep=",")



## LIWC



data2$class<-NULL
data2$X <-NULL
data2$file <-NULL

d1 <-colSums(data2 != "0")
#d1 <-colSums(data2 != 0)

b <-c()

count <-1
for(i in 1:length(d1)){ 
  if(d1[i] < 5 ){
    b[count]=(i)
    count =count +1
  }
}

data2 <- subset(data2, select = -(b))


# only for df convert all values to nummeric
x <- data2
x[] <- lapply(x, as.numeric)


data2 <- x
data2 <-as.matrix(data2)


## remove all na and nan

data2[is.na(data2)] <- 0
data2[is.nan(data2)] <- 0
data2 <-as.data.frame(data2)
data2$abc.noun <-NULL
data2$m.noun <-NULL



res.pca <- PCA(data2, graph = TRUE)

###Variances of the principal components

eigenvalues <- res.pca$eig
head(eigenvalues[, 1:2])
fviz_screeplot(res.pca, ncp=10)

#Plot the correlations/loadings of the variables with the components
#The correlation between a variable and a PC is called loading.
#The variables can be plotted as points in the component space using 
#their loadings as coordinates

head(res.pca$var$coord, 20)
head(res.pca$var$contrib, 20)

##The contribution of variables can be extracted as follow :
## too many  !!
fviz_contrib(res.pca, choice = "var", axes = 1)
## the top 7
fviz_contrib(res.pca, choice = "var", axes = 1, top = 25)
dimdesc(res.pca, axes = 1:3, proba = 0.05)
res.desc <- dimdesc(res.pca, axes = c(1,2))
res.desc$Dim.1
a<-res.desc$Dim.1
a<- as.data.frame(a)
aframe <- a[order(a$quanti.p.value), ]
head(aframe, 50)

### from server

res.pca <- PCA(data2, graph = FALSE)

###Variances of the principal components

eigenvalues <- res.pca$eig
head(eigenvalues[, 1:2])
fviz_screeplot(res.pca, ncp=10)



head(res.pca$var$coord)
##The contribution of variables can be extracted as follow :
## too many  !!
fviz_contrib(res.pca, choice = "var", axes = 1)
## the top 7
fviz_contrib(res.pca, choice = "var", axes = 1, top = 25)
dimdesc(res.pca, axes = 1:3, proba = 0.05)
res.desc <- dimdesc(res.pca, axes = c(1,2))
res.desc$Dim.1
a<-res.desc$Dim.1
a<- as.data.frame(a)
aframe <- a[order(a$quanti.p.value), ]
head(aframe, 50)


















res.desc$Dim.2
a<-res.desc$Dim.2
a<- as.data.frame(a)
aframe <- a[order(a$quanti.p.value), ]
head(aframe, 25)






