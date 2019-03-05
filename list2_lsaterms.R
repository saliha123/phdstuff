lsaconcepts<-c('acquisitions',
               'adverse',
               'amount',
               'average',
               'bank',
               'cash',
               'certain',
               'communities',
               'control',
               'costs',
               'credit',
               'currently',
               'customers',
               'debt',
               'decrease',
               'fiscal',
               'higher',
               'impact',
               'increased',
               'insurance',
               'interest',
               'investment',
               'loans',
               'lower',
               'management',
               'marketing',
               'may',
               'net',
               'operating',
               'operations',
               'procedures',
               'production',
               'products',
               'required',
               'result',
               'revenue',
               'securities',
               'total',
               'value')



lsaconcepts <- c('loans','production','products','insurance','procedures','acquisitions','operations','management','debt','decrease',
               'result','revenue','securities','certain','cash','interest','may','required','amount','net','communities',
               'decrease','lower','compared','consolidated','total','operating','respectively','accounting','effect')


lsa2<-c('may',
            'company',
            'sales',
            'development',
            'million',
            'operating',
            'december',
            'cash',
            'interest',
            'value',
            'financial',
            'credit',
            'ended',
            'revenue',
            'products',
            'operations',
            'capital',
            'results',
            'result',
            'net',
            'system',
            'systems',
            'costs',
            'certain',
            'insurance',
            'loans',
            'assets')



data2<-tdm.stack


data2 <- subset(data2, select = (PLIWC))

data3 <- subset(data2, select = (lsa2))