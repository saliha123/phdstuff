ps_ig_uni <-c('increas', 'will', 'expect', 'signific', 'addit', 'financi', 'share', 'tax', 'futur', 'sale', 'capit', 'current', 'servic', 'intern', 'period', 'requir', 'invest', 'account', 'respect', 'growth', 'basi', 'make', 'loss', 'purpos', 'asset', 'revenu', 'includ', 'annual', 'cost', 'debt')
mp_ig_uni <-c('activ', 'end', 'includ', 'expect', 'increas', 'part', 'signific', 'manag', 'account', 'indebted', 'follow', 'intern', 'respect', 'sale', 'servic', 'interest', 'valu', 'addit', 'futur', 'growth', 'period', 'expens', 'asset', 'current', 'make', 'revenu', 'primarili', 'loss', 'requir', 'purpos') 

ps_ig_bi<-c('to date', 'to higher', 'income increased', 'efficiency and', 'market our', 'of approximately', 'primarily due', 'continued to', 'improvement in', 'commitment to', 'acquisition of', 'income in', 'annual report', 'purchase price', 'year ended', 'sales increased', 'most significant', 'customers with', 'event that', 'markets and', 'the performance', 'necessary to', 'contributed to', 'failure to', 'accounting and', 'presented in', 'between the', 'accounted for', 'in compared', 'also include')
mp_ig_bi<-c('greater financial', 'failure to', 'have greater', 'event that', 'in and', 'obtain a', 'presented in', 'continued to', 'contributed to', 'service and', 'income increased', 'and lower', 'resources than', 'purchase price', 'also include', 'efficiency and', 'capital expenditures', 'primarily due', 'operating income', 'fail to', 'market our', 'the first', 'a decline', 'a increase', 'in increased', 'in compared', 'may be', 'to date', 'approximately and', 'approved by')



ps_ig_tri<-c('are expected to', 'the event that', 'of shares of', 'entered into an', 'the acquisition of', 'a range of', 'part of our', 'in the fair', 'should be read', 'a broad range', 'a change in', 'a combination of', 'a decline in', 'a decrease in', 'a increase in', 'a loss of')
mp_ig_tri<-c('the event that', 'ability to provide', 'in the event', 'primarily due to', 'based on the', 'one or more', 'entered into a', 'in the fair', 'comply with the', 'we are a', 'the end of', 'the event of', 'pursuant to the', 'of shares of', 'due to lower', 'in compared to')



ps_ig_coh<-c('DESPL', 'PCNARz', 'SMCAUSwn', 'DESPC', 'SYNSTRUTt', 'PCNARp', 'LSAPP1d', 'CNCTempx', 'WRDAOAc', 'SYNSTRUTa', 'WRDHYPnv')
mp_ig_coh<-c('LSAPP1d', 'DRPP', 'SYNSTRUTt', 'PCNARz', 'PCNARp', 'DRINF', 'WRDFRQa', 'WRDMEAc')

ps_ig_concepts<-c('stockholder.noun',
                  'procedure.noun',
                  'obtaining.verb',
                  'obtain.verb',
                  'performed.verb',
                  'refurbishment.noun',
                  'obtained.verb',
                  'offset.verb',
                  'continued.verb',
                  'identify.verb',
                  'acquisition.noun',
                  'event.noun',
                  'posted.verb',
                  'flat.Adj',
                  'failures.noun',
                  'impacted.verb',
                  'platforms.noun',
                  'mainly.Adv',
                  'depth.noun',
                  'device.noun',
                  'fragments.noun',
                  'mapped.verb',
                  'patent.verb',
                  'seizure.noun',
                  'signatures.noun',
                  'stockholm.noun',
                  'road.noun',
                  'forward.noun',
                  'improving.verb')


mp_ig_concepts<-c('improving.verb', 'distribute.verb', 'precedent.noun', 'obtained.verb', 'obtaining.verb', 'improve.verb', 'restoration.noun', 'acquisition.noun', 'cease.verb', 'merchandisers.noun', 'switches.noun', 'acquired.verb', 'ceased.verb', 'standards.noun', 'manufacturer.noun', 'division.noun', 'results.noun', 'association.noun', 'incurrence.noun', 'avoiding.verb', 'bankers.noun', 'caution.noun', 'discounts.noun', 'predictions.noun')
ps_ig_custom <-c('ForwardLooking_Freq', 'negativity_Freq', 'positivity_Freq', 'Uncert1_Freq')


ps_ig_keywords<-c('also', 'capital', 'companies', 'growth', 'result', 'operations', 'tax', 'accounting', 'bankruptcy', 'operating', 'communities', 'management', 'expected', 'stockholder', 'event', 'placement', 'servicing', 'acquisition', 'net', 'documents', 'certain', 'believed', 'failures', 'losses', 'carriers', 'procurement', 'unsecured', 'increased', 'injury', 'inspection')
mp_ig_keywords<-c('also', 'companies', 'growth', 'result', 'required', 'accounting', 'results', 'primarily', 'certain', 'losses', 'general', 'compared', 'approvals', 'demand', 'flexible', 'retained', 'due', 'unfavorable', 'unsecured', 'stockholder', 'tax', 'education', 'treasury', 'international', 'outlook', 'placement', 'servicing', 'solid', 'bankruptcy', 'decreased')
ps_ig_rutkeywords<-c('years', 'company', 'financial', 'increase', 'significant', 'capital', 'growth', 'include', 'result', 'operations', 'loss', 'tax', 'operating', 'make', 'management', 'store', 'net', 'turnover', 'rate', 'item', 'cash', 'cost', 'interest', 'high', 'total', 'revenue', 'new', 'debt', 'sale', 'reduce')
mp_ig_rutkeywords<-c('years', 'company', 'significant', 'growth', 'increase', 'include', 'result', 'loss', 'rate', 'make', 'item', 'new', 'cash', 'due', 'sale', 'tax', 'store', 'number', 'total', 'turnover', 'interest', 'high', 'revenue', 'decrease', 'risk', 'major', 'lower', 'development', 'services', 'last')



data2<-sdfotWSt

RepT <- c(rep("f", times = 102),rep("nf", times = 306))
class<- factor(RepT)

data3<-data2

data3 <- subset(data3, select = c(ps_ig_rutkeywords))
data3 <- cbind(data3, class)

data2<-data3
data3$class<-NULL

