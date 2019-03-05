

library(C50)
nm <- C5.0(train[data3], train$classT)


bigrams10 <-c("accounted for","acquisition of","and sale","annual report","be required","company in",
              "continued to","designed for","due to","event that","experience in","for fiscal",
              "group of","in and","in compared","into a","legal and","market our","necessary to",
              "of approximately","our management","our own","purchase price","the acquisition",
              "the fiscal","the worlds","to conduct","year ended")


trigrams10 <- c("an adverse effect","and sale of","at the time","company's ability to","during the period",
                "entered into a","for the year","in the event","may be required","million at december",
                "million in cash","million of cash","not believe that","of our common","our common stock",
                "primarily as a","primarily due to","provided by financing","pursuant to the", 
                "shares of common","the acquisition of","the company in","the companys ability",
                "the fiscal year","the impact of","the results of","the year ended","use of the")


library(C50)
nm <- C5.0(train[data3], train$classT)

keyterms1<-c( "division","system","agreement","bankruptcy","acquisition","stock","approval","private","corporation","insurance","stockholder","control" )  
keyterms2 <-c("carriers", "combination","installation", "common","medical", "required","initial", "process", "limited")
keyterms3 <-c("merger", "facility", "inspection", "group","balances","warrants","flexible", "assurance","capital","companies","time")
keyterm4 <-c( "ability","traditional","patent","event","servicing","documents","commission", "purchase","directors","months")
keyterm5 <-c("approvals","july","officers","consisting","pay","necessary","transfer", "injury","receivable")
keyterm6 <- c("use","date", "result","participation","individuals","read","overhead","upon","clients","exclusive","acquired","preferred")
keyterm7 <- c("management","act","believed","mass","problems","allocated", "state",  "type","retained","acquisitions","secured","without","unable","placement")
keyterm8 <- c("commissions","advertising","fund", "knowledge","target","seek","services","patents","agency","installed","perform","fuel")
keyterm9 <- c("members","networks","introduced", "according","staffing","march","payable","believe","general","incurred", "accounting")
keyterm10 <- c("purpose","claims","filing" , "procurement","contract","items", "earned","floating","unsecured","communities","million","billion","higher","compared")
keyterm11 <- c("percent","primarily","earnings","lower","notes","tax","community")
keyterm12 <- c("due","senior","fourth","software","income","share","impact","net","brand","driven","offset","rate")
keyterm13 <- c("drive","quarter","online", "gains","increased","pretax","reserves","level","program","reflecting","see","investments","declined")
keyterm14 <- c("stores","store","impacted","across","open","favorable","production","performance","communications","regulated")
keyterm15 <- c("growth","prices","strong","spending","partially", "mobile","parts","fair","storage","domestic","derivative")
keyterm16 <- c("source","portfolio","related","launched","operating","continued" ,"top","processing", "brands")
keyterm17 <- c("international", "project","chain","employee","gain","operations","pension","compensation","decreased","initiatives")
keyterm18 <- c("expected","markets","licensing","consumer","half","legislation","buy","average","euro","generation","outlook","improved","flat")
keyterm19 <- c("expected","markets","licensing","telephone","also","recorded","areas", "joint","delivery","realized", "minority", "dollar")
keyterm20 <- c("leases","flows","treasury", "short","declines","repurchase","component","users","platforms","export")
keyterm21 <- c("settlement", "shipments",  "website","results","currency","hedges","volumes","losses","remains", "disruptions")    
keyterm22 <- c("tools","committed","customer","adjustments","investment", "certain","south","contributed","like","health")
keyterm23 <- c("unfavorable","demand","education","failures","forward","sufficient")




rutherford1 <-c("loss","margin","revenue","sale","turnover","cost","performance","profit","result")
rutherford2 <-c("asset","borrowing","debt","cash","liability","currency","exchange","expenditure",
                "fixed","interest","investment","net","risk","capital","financial","share","tax")
rutherford3 <-c("rate","decrease","high","increase","growth","high")
rutherford4 <-c("overall","activity","increasingly","customer","development","due","facility","include","item","make")
rutherford5 <-c("major","management","network","number","operating","operations","products")
rutherford6 <-c("property","retail","services","significant","store","strong","systems")
rutherford7 <-c("total","trading","years","completed","continued","end","last","new","now","previous")
rutherford8 <-c("grow","higher","overall","lower","reduce","company","division")

## 204

keyterms3 <-c("merger", "facility", "inspection", "group","balances","warrants","flexible", "assurance","companies","time")
keyterm17 <- c("international", "project","chain","employee","gain","operations",
               "compensation","decreased","initiatives")
keyterm21 <- c("settlement", "shipments",  "website","results","currency","volumes","losses","remains", "disruptions")    
keyterm23 <-c("unfavorable","demand","education","forward","sufficient")
keyterm6 <- c("use","date", "result","participation","individuals","read","overhead","upon","exclusive","acquired","preferred")




rutherford2 <-c("asset","borrowing","debt","cash","liability","currency","exchange","expenditure",
                "fixed","interest","investment","net","risk","share","tax")


data2 <- subset(tdm.stack, select = c(keyterms1,keyterms2,keyterms3,keyterm4,
                                      keyterm5,keyterm6,keyterm7,keyterm8,keyterm9,keyterm10,
                                      keyterm11,keyterm12,keyterm13,keyterm14, keyterm15, keyterm16,
                                      keyterm17,keyterm18, keyterm19, keyterm20, keyterm21,
                                      keyterm22, keyterm23))


allkeywords <-c(keyterms1,keyterms2,keyterms3,keyterm4,
                           keyterm5,keyterm6,keyterm7,keyterm8,keyterm9,keyterm10,
                           keyterm11,keyterm12,keyterm13,keyterm14, keyterm15, keyterm16,
                           keyterm17,keyterm18, keyterm19, keyterm20, keyterm21,
                           keyterm22, keyterm23)





data2 <- subset(tdm.stack, select = c(rutherford1,rutherford2,rutherford3,rutherford4,rutherford5, rutherford6, rutherford7,rutherford8))



