library(tm)
library(plyr)

options(stringsASFactors = FALSE)
oz2 <- Corpus(DirSource("C:/data5/0"))

oz2 <- tm_map(oz2, content_transformer(tolower))
oz2 <- tm_map(oz2, removeNumbers)
oz2 <- tm_map(oz2, removePunctuation)
oz2 <- tm_map(oz2, removeWords, stopwords("english"))
oz2 <- tm_map(oz2, stripWhitespace)


#build up term document matrix
oz3 <- DocumentTermMatrix(oz2)
oz4 <- TermDocumentMatrix(oz2)

oz3 <- removeSparseTerms(x=oz3, sparse = 0.60)
oz4 <- removeSparseTerms(x=oz4, sparse = 0.60)


rowTotals <- apply(oz2, 1, sum) #Find the sum of words in each Document
oz2.new <- oz2[rowTotals> 0, ] #remove all docs without words???

#get some basic stats 

inspect(oz3)
freq <- colSums(as.matrix(oz3))
length(freq)

freq[tail(oz3)]
head(table(freq), 15)

findFreqTerms(oz3, lowfreq=1000)

freq <- sort(colSums(as.matrix(oz3)), decreasing=TRUE)
head(freq, 14)

wf <- data.frame(word=names(freq), freq=freq)
head(wf, 20)



library(wordcloud)
set.seed(142)
wordcloud(names(freq), freq, min.freq=1000, scale=c(5, .1), colors=brewer.pal(6, "Dark2"))

library(qdap)
words <- oz3 %>%
  as.matrix %>%
  colnames %>%
  (function(x) x[nchar(x) < 20])

length(words)
head(words, 15)

data.frame(nletters=nchar(words)) %>%
  ggplot(aes(x=nletters)) +
  geom_histogram(binwidth=1) +
  geom_vline(xintercept=mean(nchar(words)), colour="green", size=1, alpha=.5) +
  labs(x="Number of Letters", y="Number of Words")


library(dplyr)
library(stringr)
words %>%
  str_split("") %>%
  sapply(function(x) x[-1]) %>%
  unlist %>%
  dist_tab %>%
  mutate(Letter=factor(toupper(interval),
                       levels=toupper(interval[order(freq)]))) %>%
  ggplot(aes(Letter, weight=percent)) +
  geom_bar() +
  coord_flip() +
  ylab("Proportion") +
  scale_y_continuous(breaks=seq(0, 12, 2),
                     label=function(x) paste0(x, "%"),
                     expand=c(0,0), limits=c(0,12))

summary(nchar(words))

table(nchar(words))

## trigram/bigrams top 20 counts get fraud then non fraud
###go to ngram pgm and run to get tdmnf value

inspect(tdmnf)
findFreqTerms(x=tdmnf, lowfreq = 200, highfreq =Inf)
freq <- sort(rowSums(as.matrix(tdmnf)), decreasing=TRUE)
t1<-head(freq, 20)
t1<-as.data.frame(t1, stringsASFactors = FALSE)
t1<-rownames(t1)        
t1<-subset(sdfoT, select = t1)
t1<-cbind(t1, class)
write.csv(t1, file = "C:/data6/top20trigrams.csv")




wf <- data.frame(word=names(freq), freq=freq)
head(wf, 20)


##let us try clustering again

oz3 <- tm_map(oz3, content_transformer(tolower))
oz3 <- tm_map(oz3, removeNumbers)
oz3 <- tm_map(oz3, removePunctuation)
oz3 <- tm_map(oz3, removeWords, stopwords("english"))
oz3 <- tm_map(oz3, stripWhitespace)


#build up term document matrix
oz3 <- TermDocumentMatrix(oz3)

##remove sparse terms

oz3.tdm1 <- removeSparseTerms(oz3, sparse=0.95)
oz3.tdmatrix <- as.matrix(oz3.tdm1)

#hclust

distMatrix <- dist(scale(oz3.tdmatrix))
e.fit <- hclust(distMatrix, method="ward")


##plot dendogram
plot(e.fit, cex=0.9, hang=-1, main="Word Cluster Dendogram")

#cut tree
rect.hclust(e.fit, k=5)

e.groups <-cutree(e.fit, k=5)


# tf-idf
dtm_idf <- weightTfIdf(oz2.new)

## do document clustering

### k-means (this uses euclidean distance)
m<-as.matrix(dtm_idf, options(stringsASFactors = FALSE))

m2<-matrix(0,50,1)
colnames(m2)[1] <- "RepType"

m <- cbind(m, m2)

m3<-matrix(1,50,1)
colnames(m3)[1] <- "RepType" 

m <- cbind(m, m3)


rownames(m) <-1:nrow(m)


### don't forget to normalize the vectors so Euclidean makes sense

norm_eucl <- function(m) m/apply(m, MARGIN=1, FUN=function(x) sum(x^2)^.5)
m_norm <- norm_eucl(m)


##norm_eucl <-function(m)
##m/apply(m,1, function(x) sum(x^2)^.5)
##m_norm <- norm_eucl(m)
##results <-kmeans(m_norm, 12,30)

cl <- kmeans(m_norm, 10)
table(cl$cluster)

### show clusters using the first 2 principal components
plot(prcomp(m_norm)$x, col=cl$cl)


##findFreqTerms(oz2[cl[,'cluster']==1], 4)
findFreqTerms(oz2[cl$cluster==1], 50)
inspect(reuters[which(cl$cluster==1)])

## hierarchical clustering
library(proxy)

### this is going to take 4-ever (O(n^2))
d <- dist(m, method="cosine")
hc <- hclust(d, method="average")
plot(hc)

cl <- cutree(hc, 50)
table(cl)
findFreqTerms(dtm[cl==1], 50)




clusters <- 1:12
for (i in clusters){
cat("Cluster ", i, ":", findFreqTerms(dtm_idf[results$cluster==i],2),"\n\n")
}

#We can obtain the term frequencies as a vector by converting the document term matrix into a
#matrix and summing the column counts:

freq <- colSums(as.matrix(oz2.new))
length(freq)

##By ordering the frequencies we can list the most frequent terms
##and the least frequent terms:

ord <- order(freq)

freq[tail(ord)] # Most frequent terms

#remove sparse terms
inspect(removeSparseTerms(oz2.new, 0.2))

dtms <- removeSparseTerms(oz2.new, 0.2)
dim(dtms)
inspect(dtms)


#check the frequency
freq <- colSums(as.matrix(dtms))
freq


table(freq)

#find frequent items and associations
findFreqTerms(dtms, lowfreq=14)


#plot correlations
library(Rgraphviz)
##plot(oz2,terms=findFreqTerms(oz2, lowfreq=14)[1:14], corThreshold=0.6)


#plotting word frequencies
freq <- sort(colSums(as.matrix(oz2)), decreasing=TRUE)
head(freq, 20)

wf <- data.frame(word=names(freq), freq=freq)
head(wf)

library(ggplot)
#plot the frequency of the words that show up at least n times
p <- ggplot(subset(wf, freq>1000), aes(word, freq))
p <- p + geom_bar(stat="identity")
p <- p + theme(axis.text.x=element_text(angle=45, hjust=1))
p


#visualize wordcloud by setting max words
set.seed(142)
wordcloud(names(freq), freq, max.words=50)


#let's add some color and adjust text size for word frequency
set.seed(142)
wordcloud(names(freq), freq, max.words=50, scale=c(5, .1), colors=brewer.pal(6, "Dark2"))

