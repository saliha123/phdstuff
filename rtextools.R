library(RTextTools)


container <- create_container(tdm.stack.nl, tdm.rep, trainSize=1:75, testSize=76:100, virgin=FALSE)

names(attributes(container))

SVM <- train_model(container,"SVM")
GLMNET <- train_model(container,"GLMNET")
MAXENT <- train_model(container,"MAXENT")
SLDA <- train_model(container,"SLDA")
BOOSTING <- train_model(container,"BOOSTING")
BAGGING <- train_model(container,"BAGGING")
RF <- train_model(container,"RF")
NNET <- train_model(container,"NNET")
TREE <- train_model(container,"TREE")


SVM_CLASSIFY <- classify_model(container, SVM)
GLMNET_CLASSIFY <- classify_model(container, GLMNET)
MAXENT_CLASSIFY <- classify_model(container, MAXENT)
SLDA_CLASSIFY <- classify_model(container, SLDA)
BOOSTING_CLASSIFY <- classify_model(container, BOOSTING)
BAGGING_CLASSIFY <- classify_model(container, BAGGING)
RF_CLASSIFY <- classify_model(container, RF)
NNET_CLASSIFY <- classify_model(container, NNET)
TREE_CLASSIFY <- classify_model(container, TREE)

analytics <- create_analytics(container,cbind(SVM_CLASSIFY, SLDA_CLASSIFY,
                                    BOOSTING_CLASSIFY, BAGGING_CLASSIFY,
                                    RF_CLASSIFY, GLMNET_CLASSIFY,
                                    TREE_CLASSIFY,
                                    MAXENT_CLASSIFY))


# CREATE THE data.frame SUMMARIES
topic_summary <- analytics@label_summary
alg_summary <- analytics@algorithm_summary
ens_summary <-analytics@ensemble_summary
doc_summary <- analytics@document_summary


# Confusion Matrices -- look for possible problems

table(true = analytics@document_summary$MANUAL_CODE, predict = analytics@document_summary$CONSENSUS_CODE)

table(true = analytics@document_summary$MANUAL_CODE, predict = analytics@document_summary$PROBABILITY_CODE)

table(true = analytics@document_summary$MANUAL_CODE, predict = analytics@document_summary$SVM_LABEL)

table(true = analytics@document_summary$MANUAL_CODE, predict = analytics@document_summary$MAXENTROPY_LABEL)


# CHECK OVERALL ACCURACY OF ALGORITHMS
recall_accuracy (analytics@document_summary$MANUAL_CODE, analytics@document_summary$CONSENSUS_CODE)
recall_accuracy (analytics@document_summary$MANUAL_CODE, analytics@document_summary$PROBABILITY_CODE)
recall_accuracy (analytics@document_summary$MANUAL_CODE, analytics@document_summary$MAXENTROPY_LABEL)
recall_accuracy (analytics@document_summary$MANUAL_CODE, analytics@document_summary$SVM_LABEL)

analytics@ensemble_summary

