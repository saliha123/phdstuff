library(lsa)

lsa_data <-nftdm_stack
lsa_data <-tdm.stack 

 
lsa_data[is.na(lsa_data)] <- 0    
lsa_data$classT <-NULL
scale(lsa_data)  



lsa_data <-lsa_data[,colSums(lsa_data != 0) != 0]   
lsa_data<- lsa(lsa_data, dims=dimcalc_share())

a <- round(as.textmatrix(lsa_data),2)
           
summary(a)


cosine(a, y=NULL)






### try mds

dist.mat.lsa <- dist(t(as.textmatrix(lsa_mat)))  # compute distance matrix
dist.mat.lsa



