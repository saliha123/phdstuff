#Dictionaries

data2 <- read.csv(file="C:/data6/wa/Dictionaries/L&M Sentimentsv9csv.csv", header=TRUE, sep=",")


data2 <- read.csv(file="C:/data6/wa/L&M Sentiments204v7.csv", header=TRUE, sep=",")


data2<-read.csv(file="C:/data6/wa/L&M Sentimentsv5csv.csv", header=TRUE, sep=",")


data2$Fraud.Non.Fraud.Firms<-NULL
data2$X<-NULL
data2$X.1<-NULL
data2$X.2<-NULL



data2$Report_Word_Count<-NULL
data2$X<-NULL

data3<-data2


# coh_metrix
data2 <- read.csv(file="C:/data6/wa/Coh_Metrix/cohwholecsvall.csv", header=TRUE, sep=",")

data2 <- read.csv(file="C:/data6/wa/cohwholecsv.csv", header=TRUE, sep=",")
data2$X<-NULL
data2<-data2[1:204,]


data2 <- read.csv(file="C:/data6/wa/Coh_Metrix/cohmetrix204v4.csv", header=TRUE, sep=",")
data2$X<-NULL

# topics
data2 <- read.csv(file="c:/data6/wa/topicmallet/topicscsvall.csv", header=TRUE, sep=",")
data2$file<-NULL
data2 <- data2[1:204,]

#ratios
data2 <- read.csv(file="c:/data6/wa/LBC/ratios_csv_V4.csv", header=TRUE, sep=",")
data2$X <-NULL

data2 <- data2[1:204,]

#concepts
data2 <- read.csv(file= "C:/data6/wa/concepts/concepts204.csv", header=TRUE, sep=",")
data2 <- read.csv(file= "C:/data6/wa/concepts/Final Concepts 408_matrixv2csv.csv", header=TRUE, sep=",")

#LIWC
data2 <- read.csv(file="c:/data6/new LIWC results/LIWCCSVALL.csv", header=TRUE, sep=",")
data2$Filename <- NULL

