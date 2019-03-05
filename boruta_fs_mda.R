boruta_unigrams_ps <- c("interest", "invest", "expect", "made", "manag", "meet", "increas", "order",  "princip", "provid", "outlook", "recent",  "statement", "tax", "revenu", "unit", "account", "addit", "signific", "asset", "capit", "current", "loss", "financi", "futur","growth", "make", "requir", "share","satisfactori")
boruta_unigrams_mp<-c("growth", "interest", "asset", "increas", "signific", "plan", "revenu", "maintain", "statement", "loss")

boruta_trigrams_ps<-c('an adverse effect',
                      'and sale of',
                      'at the time',
                      'during the period',
                      'entered into a',
                      'for the year',
                      'in the event',
                      'may be required',
                      'million at december',
                      'million in cash',
                      'million of cash',
                      'not believe that',
                      'of our common',
                      'our common stock',
                      'primarily as a',
                      'primarily due to',
                      'provided by financing',
                      'pursuant to the',
                      'shares of common',
                      'the acquisition of',
                      'the company in',
                      'the fiscal year',
                      'the impact of',
                      'the results of',
                      'the year ended',
                      'use of the')

boruta2_trigrams_ps <-  c( 'an adverse effect',
                           'and sale of',
                           'at the time',
                           'during the period',
                           'entered into a',
                           'for the year',
                           'in the event',
                           'may be required',
                           'million in cash',
                           'million of cash',
                           'not believe that',
                           'of our common',
                           'our common stock',
                           'primarily as a',
                           'primarily due to',
                           'provided by financing',
                           'shares of common',
                           'the acquisition of',
                           'the company in',
                           'the fiscal year',
                           'the impact of',
                           'the results of',
                           'the year ended',
                           'use of the')
                     
                     

boruta_trigrams_mp <-c('comply with the',
                       'the acquisition of',
                       'the event that',
                       'we may not',
                       'which may be',
                       'primarily due to',
                       'in compared to',
                       'and will be',
                       'in addition the',
                       'the end of')



boruta_bigrams_ps_2 <-c('accounted for',
                        'have any',
                        'market our',
                        'since the',
                        'the event',
                        'to date',
                        'total revenues',
                        'acquisition of',
                        'in and',
                        'of approximately',
                        'state of',
                        'the fiscal',
                        'to enter',
                        'volume of',
                        'borrowings under',
                        'into a',
                        'product offerings',
                        'subsidiaries are',
                        'the state',
                        'to for',
                        'with those',
                        'event that',
                        'july the',
                        'segment of',
                        'the acquisition',
                        'them to',
                        'to obtain')



boruta_bigrams_ps <-c('accounted for',
                       'acquisition of',
                       'and sale',
                       'annual report',
                       'be required',
                       'company in',
                       'continued to',
                       'designed for',
                       'due to',
                       'event that',
                       'experience in',
                       'for fiscal',
                       'group of',
                       'in and',
                       'in compared',
                       'into a',
                       'legal and',
                       'market our',
                       'necessary to',
                       'of approximately',
                       'our management',
                       'our own',
                       'purchase price',
                       'the acquisition',
                       'the fiscal',
                       'to conduct',
                       'total revenues',
                       'borrowings under',
                       'to obtain',
                       'year ended')





boruta_bigrams_mp<-c('acquisition of', 'be limited', 'continued to', 'operating income', 'commitment to', 'contributed to', 'greater financial', 'primarily due', 'have greater', 'income increased')

boruta_coh_ps<-c('CNCADC', 'CNCNeg', 'CNCTempx', 'CRFNO1', 'DESPC', 'DESPL', 'DESPLd', 'DRGERUND', 'DRPVAL', 'DRVP', 'LSAPP1', 'PCNARz', 'SMCAUSwn', 'WRDFRQa', 'WRDVERB')

boruta2_coh_ps<-c('CNCADC',
                  'CNCAdd',
                  'CNCNeg',
                  'CNCTempx',
                  'CRFANP1',
                  'CRFNO1',
                  'CRFNOa',
                  'CRFSOa',
                  'DRGERUND',
                  'DRINF',
                  'DRPVAL',
                  'DRVP',
                  'LSASS1d',
                  'PCCNCz',
                  'PCCONNz',
                  'PCNARz',
                  'PCVERBz',
                  'RDFKGL',
                  'SMCAUSlsa',
                  'SMCAUSwn',
                  'SYNLE',
                  'SYNSTRUTa',
                  'SYNSTRUTt',
                  'WRDADJ',
                  'WRDAOAc',
                  'WRDFRQa',
                  'WRDIMGc',
                  'WRDMEAc',
                  'WRDVERB')


boruta_coh_mp<-c('LSAPP1d', 'WRDPOSin', 'SYNSTRUTt', 'DRVP', 'DRPP', 'WRDADJ', 'WRDFRQa', 'WRDHYPnv')


boruta_liwc_ps<-c('Clout', 'auxverb', 'focuspresent', 'Authentic', 'verb', 'focusfuture', 'function.', 'adj', 'relativ', 'pronoun', 'compare', 'ppron', 'interrog', 'article', 'cogproc') 
boruta_liwc_mp<-c('Analytic', 'interrog', 'Authentic', 'relativ', 'Tone', 'ipron', 'prep', 'auxverb', 'adj')

boruta_custom_ps<-c('positivity_Freq', 'ForwardLooking_Freq', 'Constraining', 'Uncert1_Freq', 'Litiguous', 'negativity_Freq', 'Modal.Weak', 'class')


boruta2_custom_ps<-c('positivity_Freq', 'ForwardLooking_Freq',  'Uncert1_Freq', 'negativity_Freq', 'Modal.Weak', 'Constraining')



boruta_custom_mp<-c('Constraining', 'Risk')


boruta_topic_ps<-c('Topic.3',
                    'Topic.24',
                    'Topic.4',
                    'Topic.5',
                    'Topic.12',
                    'Topic.18',
                    'Topic.22')



boruta_topic_mp<-c('Topic.3', 'Topic.4', 'Topic.21', 'Topic.24')

boruta_LBC_ps<-c('passive.verb.ratio', 'Sentence.Qty', 'Word.Qty', 'Modal.Verb.Ratio', 'Pausality', 'Function.Word.Diversity', 'Group.Ref', 'Modifier.Qty', 'Verb.Qty', 'Temporal.Imm..Ratio')

boruta_LBC_mp<-c('Content.Word.Diversity', 'Other.Ref', 'Group.Ref', 'Modal.Verb.Ratio')


boruta_concept_ps<-c('accounts.noun',
                      'acquired.verb',
                      'acquisition.noun',
                      'amounting.verb',
                      'arranged.verb',
                      'assigned.verb',
                      'clients.noun',
                      'collect.verb',
                      'companies.noun',
                      'consisting.verb',
                      'continued.verb',
                      'credit.noun',
                      'discourage.verb',
                      'employee.noun',
                      'ended.verb',
                      'entered.verb',
                      'event.noun',
                      'expenses.noun',
                      'frequently.Adv',
                      'improve.verb',
                      'losses.noun',
                      'manufactures.noun',
                      'obtained.verb',
                      'performed.verb',
                      'procedure.noun',
                      'purchase.noun',
                      'put.verb',
                      'relates.verb',
                      'results.noun',
                      'stockholder.noun')

boruta_concept_mp<-c('accounts.noun', 'acquired.verb', 'acquisition.noun', 'amounting.verb', 'arranged.verb', 'assigned.verb', 'clients.noun', 'collect.verb', 'companies.noun', 'consisting.verb', 'continued.verb', 'credit.noun', 'discourage.verb', 'employee.noun', 'ended.verb', 'entered.verb', 'event.noun', 'expenses.noun', 'frequently.Adv', 'improve.verb')

boruta_key204<-c('accounting', 'acquisition', 'bankruptcy', 'believed', 'certain', 'communities', 'companies', 'compared', 'demand', 'economic', 'flexible', 'growth', 'losses', 'primarily', 'procurement', 'result', 'results', 'tax', 'treasury', 'unfavorable', 'unsecured')

boruta_key408<-c('accounting', 'communities', 'management', 'operations', 'purchase', 'tax', 'acquisition', 'capital', 'companies', 'growth', 'outlook', 'staffing', 'compared', 'expected', 'hedges', 'required', 'stockholder', 'bankruptcy', 'certain', 'failures', 'unfavorable', 'believed', 'operating', 'procurement', 'results', 'unsecured')

boruta_rut408<-c('activity', 'high', 'management', 'revenue', 'years', 'capital', 'include', 'net', 'significant', 'loss', 'company', 'increase', 'operating', 'store', 'rate', 'financial', 'interest', 'operations', 'tax', 'growth', 'make', 'result', 'turnover', 'total')
boruta_rut204<-c('cash', 'include', 'loss', 'result', 'total', 'company', 'increase', 'make', 'sale', 'turnover', 'due', 'interest', 'new', 'significant', 'years', 'growth', 'item', 'number', 'store', 'high', 'last', 'rate', 'tax')



RepT <- c(rep("f", times = 102),rep("nf", times = 306))
class<- factor(RepT)


data3<-data2
data3 <- subset(data3, select = (boruta_rut408))

data3 <- cbind(data3, class)
data2<-data3
data3$class<-NULL


