library(tm)
options(header=False, stringAsFactor=FALSE)



# set Parameters
reports <- c("Fraud", "Non Fraud")
pathname <- "C:/data4"

s.dir <- sprintf("%s/%s", pathname, reports)
s.cor <- Corpus(DirSource(directory = s.dir, encoding = "ANSI"))


s.cor <- tm_map(s.cor, removePunctuation)
s.cor <- tm_map(s.cor, tolower)
s.cor <- tm_map(s.cor, removeNumbers)
s.cor <- tm_map(s.cor, removeWords, stopwords("english"))
s.cor <- tm_map(s.cor, stripWhitespace)


dtm <- DocumentTermMatrix(s.cor)

xTfIdf <- weightTfIdf(dtm)


#clustering
m = as.matrix(xTfIdf)
rownames(m) = 1:nrow(m)

norm_eucl <- function(m) m/apply(m,1,function(x) sum(x^2)^5)


m_norm <- norm_eucl(m)
results <-kmeans(m_norm,12,30)

clusters<-1:12
for(i in clusters){
  cat ("Cluster",i,":", findFreqTerms(xTfIdf[results$cluster==i],2),"\n\n")
}

