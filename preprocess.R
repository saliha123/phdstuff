
to_remove2 <- c("TextEasaPCCon","LIWCInsight","PrepPhraseDens","TextEasaPCTemp","LIWCConj","LIWCPrep","CausalVerbs","TextEasaPCRfCoh","MnSentLen","LIWCIncl","LIWCTent","LIWCRelativity","LIWCPrestensVbs","LIWCExcl","Verbs","Adj","LIWCNum","LIWCPosWrdsLM")           	

to_remove3 <- c("LeftEmbWdsBefMainVrb","ContWdOvlpAllSent","ÿLIWCQuant","MeaningContWds","ÿLIWCAuxVbs","FamContWds","Allcon","LIWCCausal","SentlenStanDev", "LIWCCogMech","LIWCNegWdsLM","ContWdOvlpAdjSent", "FeschRd","AgtlessPassVoiceDens","LIWCPosEmot")                  

to_remove4 <- c("LIWCPasttenseVbs","SenSynSimAllComb","LexdivContWd", "AdvPhraseDens","LIWCPassVbsLM","Num.of.Sent","LIWCPercProc","RCasPartCausalVbs","NumModPerNounPhrase","WdlenNumofSyllSD","RintPartIntVbs","ImagContWds","ExptempCon","ArgOvrlapAllsent","LIWCWds.6.let","LIWC3rdpersplur","TextEasaPCWdConc","LSAOvlpAdjSent")              							

to_remove5 <- c( "ÿLIWCComVbs","Nouns","LIWCArt", "LIWC1stpersplur","Total.Function.Words","LSASentAll","IntVerbs","Total.Pronouns","LIWCNegEmot","LIWCFuttensVbs","LIWCImperspron")                             

data2[to_remove5] <- list(NULL)

data3 <- data.frame(data1)

to_add1 <- c( "TextEasaPCTemp","CausalVerbs", "LIWCInsight", "SentlenStanDev", "TextEasaPCRfCoh","ArgOvrlapAllsent","TextEasaPCCon")
              
to_add2 <- c( "MnSentLen", "ContWdOvlpAllSent", "FamContWds", "ContWdOvlpAdjSent", "NumModPerNounPhrase", "LIWCPassVbsLM", "LexdivContWd", "LeftEmbWdsBefMainVrb","RintPartIntVbs", "LIWCImperspron", "LIWCArt", "LIWCRelativity", "LSAOvlpAdjSent")


to_removeFIN <- c("Total.Words","Adv","NounPhraseDens", "VerbPhraseDens", "TextEasaPCdpCoh","Lexdivallword","SentSyntSimAdjSent","CWdFreqContWds","ConContWds","PolyContWds","WdlenNumofSyll","Personal.Pronouns", "LIWC1stpersing","LIWC2ndper", "LIWC3rdpersing","LIWCNeg","LIWCAffectProc","LIWCDiscrep", "LIWCCertain","LIWCInhibit", "LIWCModWdsStrongLM","LIWCModWrdsWeakLM", "LIWCUncertLM", "LIWCModalVrbsLM","class")    

data8<-subset(data1, select = c(to_add1, to_add2))

data3[to_removeFIN] <- list(NULL)
data3 <- cbind(data3, data1[87])
data8 <- cbind(data8, data1[87])
