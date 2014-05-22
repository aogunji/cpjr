##All variables were transformed with the following:



Test<-data.frame(subtest, ytest)
Train<-data.frame(subtrain,ytrain)
testtrain<-data.frame(xtest, xtrain)

colnames(xtest)<-features$V2
colnames(xtrain)<-features$V2

colnames(Test)<-c("subject", "activity")
colnames(Train)<-c("subject", "activity")

unified1<-gsub("1","walking",unified)
unified1<-gsub("2","walkingupstairs",unified1)
unified1<-gsub("3","walkingdownstairs",unified1)
unified1<-gsub("4","sitting",unified1)
unified1<-gsub("5","standing",unified1)
unified1<-gsub("6","laying",unified1)
