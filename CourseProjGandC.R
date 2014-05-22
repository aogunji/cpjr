##read data into R
subtest<-read.table("./UCI HAR dataset/test/subject_test.txt")
xtest<-read.table("./UCI HAR dataset/test/X_test.txt")
ytest<-read.table("./UCI HAR dataset/test/y_test.txt")

subtrain<-read.table("./UCI HAR dataset/train/subject_train.txt")
xtrain<- read.table("./UCI HAR dataset/train/X_train.txt")
ytrain<-read.table("./UCI HAR dataset/train/y_train.txt")

activitylab<-read.table("./UCI HAR dataset/activity_labels.txt")
features<-read.table("./UCI HAR dataset/features.txt")

## Create new data sets for test and train
Test<-data.frame(subtest, ytest)
Train<-data.frame(subtrain,ytrain)
testtrain<-data.frame(xtest, xtrain)

#Create data set combo of Test and Train
combo<-rbind(Test,Train)

#Name the columns using the features for the data set
colnames(xtest)<-features$V2
colnames(xtrain)<-features$V2

##Rename Columns
colnames(Test)<-c("subject", "activity")
colnames(Train)<-c("subject", "activity")


##Created data frame combining Subject, activity with each greater set
combotest<-data.frame(Test,xtest)
combotrain<-data.frame(Train,xtrain)

##Bound all data sets by row
combodata<-rbind(combotest,combotrain)

##Isolate all variables with mean and std present in the names
combodatamean<-combodata[,grep("mean", names(combodata))]
combodatastd<-combodata[,grep("std", names(combodata))]

boundcombo<-data.frame(combodatamean,combodatastd)

##combine test and train data with greater set
unified<-cbind(combo, boundcombo)

##NEXT STEP CBIND THE TWO COLUMNED DATA SET TO COMBODATAMEAN AND COMBODATASTD**

unified<-cbind(combodata, boundcombo)
unified<-as.character(unified$activity)

##Replace all activity numbers with correlating activity name
unified1<-gsub("1","walking",unified)
unified1<-gsub("2","walkingupstairs",unified1)
unified1<-gsub("3","walkingdownstairs",unified1)
unified1<-gsub("4","sitting",unified1)
unified1<-gsub("5","standing",unified1)
unified1<-gsub("6","laying",unified1)

unicombo<-data.frame(subject=combo$subject, activity=unified1, boundcombo))
##melt data into skinny format with subject, activity, and all other variables in column format
library(reshape2)
unicombo1<-melt(unicombo, id.vars=c("subject","activity"))

##obtain the mean for each column for each activity and subject
unicombo2<-dcast(unicombo1, subject+activity~variable,fun.aggregate=mean)
names(unicombo2)<-tolower(gsub("[^[:alnum:]]","", names(unicombo2)))

#Extract data into csv file
write.csv(unicombo2,file="./unifiedcombo.csv")

