library("MASS")
library(ggfortify)

data2<- sdfotWSt
data2<-tdm.stack


PSUnigrams <-c('strong', 'subject', 'certain', 'may', 'now', 'upon', 'expens', 'achiev', 'aim', 'despit', 'way', 'world', 'oblig', 'togeth', 'around', 'strength', 'progress', 'new', 'relat', 'obtain', 'grow', 'launch', 'affect', 'strengthen', 'took', 'great', 'requir', 'addit', 'portion', 'enjoy', 'incur', 'import', 'avail', 'group', 'determin', 'move', 'toward', 'restrict', 'bring', 'start', 'primarili', 'peopl', 'top', 'advers', 'alreadi', 'liabil', 'profit', 'effect', 'excel', 'clear')
MPUnigrams <- c('addit', 'may', 'requir', 'current', 'effect', 'futur', 'expens', 'certain', 'signific', 'rate', 'subject', 'primarili', 'believ', 'estim', 'account', 'cash', 'avail', 'also', 'increas', 'includ', 'expect', 'use', 'basi', 'liabil', 'activ', 'base', 'revenu', 'respect', 'sell', 'oblig', 'obtain', 'upon', 'loss', 'period', 'purpos', 'need', 'tax', 'approxim', 'actual', 'credit', 'general', 'decreas', 'due', 'portion', 'third', 'state', 'can', 'financ', 'follow', 'suffici')

PSTrigrams <-c('our ability to', 'adversely affect our', 'we do not', 'if we are', 'may not be', 'portion of our', 'effect on our', 'we may be', 'we may not', 'we are unable', 'require us to', 'not be able', 'any of our', 'in the future', 'are unable to', 'be able to', 'could result in', 'we are subject', 'could adversely affect', 'we believe that', 'on our ability', 'price of our', 'related to our', 'and we may', 'of our common', 'affect our business', 'in addition we', 'we are not', 'all of our', 'affect our ability', 'we fail to', 'our results of', 'our operating results', 'on our business', 'some of our', 'of our products', 'we are required', 'if we do', 'in addition our', 'our common stock', 'we could be', 'beyond our control', 'if any of', 'if we fail', 'of our competitors', 'the market price', 'be adversely affected', 'cause us to', 'that we will', 'be unable to')
MPTrigrams <- c('our ability to', 'adversely affect our', 'may not be', 'portion of our', 'effect on our', 'we do not', 'we are unable', 'if we are', 'could result in', 'not be able', 'we may not', 'we may be', 'related to our', 'on our ability', 'affect our ability', 'to meet our', 'we believe that', 'could adversely affect', 'in the future', 'we are not', 'of our common', 'require us to', 'price of our', 'believe that our', 'be able to', 'we are subject', 'that we will', 'are subject to', 'any of our', 'we fail to', 'our operating results', 'limit our ability', 'all of our', 'which could adversely', 'if we fail', 'we are required', 'results of operations', 'to our business', 'affect our business', 'our results of', 'our business and', 'cause us to', 'of our competitors', 'our common stock', 'may result in', 'which could have', 'are unable to', 'be adversely affected', 'in addition we', 'changes in our')

PSBigrams <- c('we may', 'on our', 'our ability', 'if we', 'of our', 'may not', 'may be', 'not be', 'ability to', 'do not', 'affect our', 'or our', 'our business', 'adversely affect', 'which could', 'result in', 'us or', 'and may', 'our current', 'require us', 'we do', 'could result', 'that we', 'could be', 'unable to', 'we believe', 'or other', 'and our', 'although we', 'that our', 'our revenues', 'fail to', 'be able', 'our operating', 'could adversely', 'are unable', 'and could', 'our financial', 'our future', 'subject to', 'our stock', 'we could', 'longterm debt','our competitors', 'we cannot', 'our cash', 'our products','could have', 'to obtain')
MPBigrams<-c('on our', 'we may', 'our ability', 'ability to', 'may not', 'of our', 'our business', 'result in', 'if we', 'adversely affect', 'affect our', 'that we', 'believes that', 'could adversely', 'could result', 'do not', 'we believe', 'may be', 'which could', 'and our', 'subject to', 'operating activities', 'or our', 'in our', 'we do', 'and may', 'are subject', 'could have', 'our current', 'that our', 'the outstanding', 'could cause', 'our financial', 'be able', 'our operating', 'could be', 'and could', 'may result', 'upon our', 'of operations', 'for our', 'interest rate', 'cash flow', 'require us', 'although we', 'we currently', 'if our', 'to obtain', 'results of', 'reduce our')

PCohmetrix <-c('PCREFp', 'CRFCWO1', 'PCREFz', 'LSASS1', 'LSAGN', 'CRFCWOa', 'LSASSp', 'CRFAO1', 'CRFAOa', 'CRFSO1', 'RDFRE', 'CRFNO1', 'LDTTRc', 'CRFCWOad', 'SYNMEDlem', 'RDFKGL', 'SYNMEDwrd', 'LDTTRa', 'PCVERBz', 'PCVERBp', 'CRFCWO1d', 'LDMTLD', 'CNCNeg', 'CRFSOa', 'DESWLsy', 'WRDFRQc', 'CNCADC', 'WRDAOAc', 'CRFNOa', 'LSASSpd', 'WRDMEAc', 'DESWC', 'WRDPOLc', 'WRDFAMc', 'CNCAll', 'CNCLogic', 'PCCONNz', 'PCCONNp', 'DESWLsyd', 'DRNEG', 'CNCAdd', 'DESWLltd', 'LSASS1d', 'WRDIMGc', 'DESSL', 'DESWLlt', 'WRDFRQa', 'WRDHYPn', 'DESSC', 'SMCAUSv')
MCohmetrix <-c('PCREFp', 'CRFCWO1', 'PCREFz', 'LSASS1', 'LSAGN', 'CRFCWOa', 'LSASSp', 'CRFAO1', 'CRFAOa', 'CRFSO1', 'RDFRE', 'CRFNO1', 'LDTTRc', 'CRFCWOad', 'SYNMEDlem', 'RDFKGL', 'SYNMEDwrd', 'LDTTRa', 'PCVERBz', 'PCVERBp', 'CRFCWO1d', 'LDMTLD', 'CNCNeg', 'CRFSOa', 'DESWLsy', 'WRDFRQc', 'CNCADC', 'WRDAOAc', 'CRFNOa', 'LSASSpd', 'WRDMEAc', 'DESWC', 'WRDPOLc', 'WRDFAMc', 'CNCAll', 'CNCLogic', 'PCCONNz', 'PCCONNp', 'DESWLsyd', 'DRNEG', 'CNCAdd', 'DESWLltd', 'LSASS1d', 'WRDIMGc', 'DESSL', 'DESWLlt', 'WRDFRQa', 'WRDHYPn', 'DESSC', 'SMCAUSv')


PLIWC<-c('pronoun', 'Analytic', 'ppron', 'function.', 'drives', 'Clout', 'verb', 'focusfuture', 'auxverb', 'focuspresent', 'cogproc', 'number', 'negate', 'article', 'AllPunc', 'conj', 'relativ', 'WC', 'focuspast', 'interrog', 'quant', 'WPS', 'affect', 'prep', 'Authentic', 'adverb', 'percept', 'compare', 'Tone', 'ipron', 'adj')
MPLIWC <- c('Analytic', 'pronoun', 'ppron', 'cogproc', 'focusfuture', 'negate', 'number', 'function.', 'drives', 'conj', 'Clout', 'verb', 'focuspresent', 'auxverb', 'article', 'relativ', 'focuspast', 'WC', 'Authentic', 'quant', 'prep', 'AllPunc', 'Tone', 'interrog', 'WPS', 'percept', 'compare', 'ipron', 'Tone', 'ipron', 'adj')

PSDict <- c('Modal.Weak', 'Uncert1_Freq', 'Constraining', 'ForwardLooking_Freq', 'negativity_Freq', 'Litiguous', 'positivity_Freq')

PTopics<-c('Topic.4', 'Topic.5', 'Topic.24', 'Topic.10', 'Topic.7', 'Topic.3', 'Topic.14', 'Topic.6', 'Topic.23', 'Topic.15', 'Topic.22', 'Topic.1', 'Topic.0', 'Topic.11', 'Topic.17', 'Topic.9')
MTopics<-c('Topic.4', 'Topic.5', 'Topic.24', 'Topic.7', 'Topic.10', 'Topic.23', 'Topic.3', 'Topic.14', 'Topic.6', 'Topic.1', 'Topic.15', 'Topic.12', 'Topic.0', 'Topic.11', 'Topic.17', 'Topic.9')

PSLBC <- c('Sentence.Qty', 'Pausality', 'Word.Qty', 'Function.Word.Diversity', 'Modifier.Qty', 'Lexical.Diversity', 'Modal.Verb.Ratio', 'Group.Ref', 'Temporal.Imm..Ratio', 'Avg.Sent.Length', 'Content.Word.Diversity', 'Imagery', 'Sensory.Ratio', 'Verb.Qty', 'Pleasantness', 'Avg.Word.Length')
MLBNS <-c('Modifier.Qty', 'Word.Qty', 'Sentence.Qty', 'Pausality', 'Function.Word.Diversity', 'Modal.Verb.Ratio', 'Lexical.Diversity', 'Group.Ref', 'Avg.Sent.Length', 'Affect', 'Avg.Word.Length', 'Pleasantness', 'Verb.Qty','Emotiveness','Imagery', 'Content.Word.Diversity')

mkey<-c('primarily', 'rate', 'due', 'results', 'related', 'income', 'compared', 'tax', 'lower', 'accounting', 'certain', 'also', 'offset', 'higher', 'decreased', 'partially', 'losses', 'unsecured', 'impact', 'favorable', 'increased', 'unfavorable', 'required', 'fair', 'million', 'investments', 'flows', 'net', 'fourth', 'adjustments', 'ability', 'result', 'compensation', 'growth', 'realized', 'approvals', 'earnings', 'currency', 'date', 'quarter', 'flat', 'gains', 'believe', 'acquisition', 'general', 'average', 'chain', 'upon', 'operating', 'shipments')
pkey <-c('offset', 'rate', 'primarily', 'compared', 'related', 'partially', 'income', 'net', 'due', 'tax', 'lower', 'recorded', 'higher', 'results', 'decreased', 'million', 'losses', 'fair', 'accounting', 'flows', 'quarter', 'currency', 'gains', 'favorable', 'hedges', 'capital', 'fourth', 'unfavorable', 'earnings', 'investments', 'unsecured', 'impact', 'declines', 'pretax', 'pension', 'certain', 'impacted', 'driven', 'gain', 'result', 'notes', 'management', 'adjustments', 'also', 'realized', 'compensation', 'system', 'dollar', 'failures', 'stockholder')
pruth <-c('financial', 'rate', 'capital', 'significant', 'increase', 'interest', 'result', 'cash', 'tax', 'include', 'net', 'years', 'new', 'loss', 'debt', 'management', 'operating', 'operations', 'due', 'company', 'decrease', 'total', 'cost', 'sale', 'store', 'growth', 'lower', 'make', 'revenue', 'higher', 'currency', 'item', 'activity', 'exchange', 'reduce', 'products', 'turnover', 'liability', 'division', 'margin', 'now', 'strong', 'borrowing', 'investment', 'risk', 'services', 'previous', 'property', 'asset', 'trading')
mruth <-c('rate', 'include', 'significant', 'increase', 'due', 'years', 'cash', 'loss', 'tax', 'interest', 'growth', 'result', 'make', 'company', 'decrease', 'total', 'revenue', 'lower', 'sale', 'new', 'higher', 'debt', 'development', 'item', 'high', 'store', 'operating', 'activity', 'risk', 'number', 'services', 'currency', 'investment', 'turnover', 'share', 'completed', 'liability', 'strong', 'net', 'exchange', 'division', 'property', 'overall', 'continued', 'retail', 'asset', 'operating', 'shipments')
mcon <-c('make.verb',
         'based.verb',
         'requirements.noun',
         'ability.noun',
         'policies.noun',
         'affect.verb',
         'determined.verb',
         'required.verb',
         'property.noun',
         'paid.verb',
         'investing.verb',
         'payment.noun',
         'requires.verb',
         'compete.verb',
         'compensation.noun',
         'consider.verb',
         'restrictions.noun',
         'payments.noun',
         'loss.noun',
         'purchase.noun',
         'fees.noun',
         'fail.verb',
         'require.verb',
         'funding.verb',
         'rates.noun',
         'limitations.noun',
         'purposes.noun',
         'provide.verb',
         'agreements.noun',
         'meet.verb',
         'acquiring.verb',
         'obligations.noun',
         'sale.noun',
         'determine.verb',
         'liability.noun',
         'expense.noun',
         'liabilities.noun',
         'portion.noun',
         'including.verb',
         'maintain.verb',
         'types.noun',
         'losses.noun',
         'action.noun',
         'activities.noun',
         'fee.noun',
         'agencies.noun',
         'occur.verb',
         'evaluate.verb',
         'transaction.noun',
         'include.verb')


pcon <-c('including.verb', 'ability.noun', 'based.verb', 'restrictions.noun', 'make.verb', 'events.noun', 'requirements.noun', 'required.verb', 'determined.verb', 'affect.verb', 'change.verb', 'amount.noun', 'changes.noun', 'compensation.noun', 'addition.noun', 'include.verb', 'expense.noun', 'arrangements.noun', 'fail.verb', 'requires.verb', 'activities.noun', 'payments.noun', 'compete.verb', 'agreements.noun', 'require.verb', 'purposes.noun', 'credit.noun', 'circumstances.noun', 'event.noun', 'obligations.noun', 'requiring.verb', 'parties.noun', 'loss.noun', 'purchase.noun', 'existing.verb', 'assets.noun', 'disclosure.noun', 'number.noun', 'portion.noun', 'apply.verb', 'failure.noun', 'regulations.noun', 'issued.verb', 'accounting.noun', 'action.noun', 'laws.noun', 'rate.noun', 'provision.noun', 'equity.noun', 'issuance.noun')




data2 <-tdm.stack

data2 <-sdfotWSt

data2 <- subset(data2, select = (PLIWC))

data3 <- subset(data2, select = (PSDict))

data2 <- data3

data3$class<-NULL

num <- c(1:204)
data2["hdr"] <- num
row.names(data2) <- data2[, 11]

x <- data2
x[] <- lapply(x, as.numeric)
data2 <- x

d <- dist(data2)
mds <- isoMDS(d)
mds$points
Dim1 <- mds$points [1:102,]
Dim2 <- mds$points [103:204,]


fit <- cmdscale(d, eig = TRUE, k = 2)
fit$points
Dim1 <- fit$points [1:102,]
Dim2 <- fit$points [103:408]


plot(Dim1, xlab="Dim1", ylab="Dim2",
     mgp=c(2,1,0), pch=21,
     bg= "black", col="black")



plot(Dim1, xlab="Dim1", ylab="Dim2",
     mgp=c(2,1,0), pch=24,
     bg= "black", col="black")

title("Peer Set Concepts PCA", line = 0.5)
points(Dim2, pch=21, bg="red", col="red")

legend("topright", inset=.01,  # places a legend at the appropriate place c("Health","Defense"), # puts text in the legend 
       c("f", "nf"),
       pch = c(24,21),
       col =  c("black","red"),
       pt.bg =c("black","red")) 

