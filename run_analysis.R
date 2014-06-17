library(data.table)

zipFile<-"UCI HAR Dataset.zip"
#download the file, if not already downloaded
if(!file.exists(zipFile)){
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile=zipFile, method='curl')
        dateDownloaded <- date()
}
#read column names to be used for 'X' files
colNames<-read.table(file=unz(description=zipFile, file="UCI HAR Dataset/features.txt"))

#read test data
x_test<-read.table(file=unz(description=zipFile, file="UCI HAR Dataset/test/X_test.txt"), col.names=colNames[,2])
y_test<-read.table(file=unz(description=zipFile, file="UCI HAR Dataset/test/y_test.txt"))
subject_test<-read.table(file=unz(description=zipFile, file="UCI HAR Dataset/test/subject_test.txt"))
#read train data
x_train<-read.table(file=unz(description=zipFile, file="UCI HAR Dataset/train/X_train.txt"), col.names=colNames[,2])
y_train<-read.table(file=unz(description=zipFile, file="UCI HAR Dataset/train/y_train.txt"))
subject_train<-read.table(file=unz(description=zipFile, file="UCI HAR Dataset/train/subject_train.txt"))

#read the description of activity codes
activity_labels<-read.table(file=unz(description=zipFile, file="UCI HAR Dataset/activity_labels.txt"))

#join rows of X test and X train datasets
x<-rbind(x_test, x_train)
#join rows of Y test and Y train datasets
y<-rbind(y_test, y_train)
#join rows of Subject test and subject train datasets
subject<-rbind(subject_test, subject_train)

#set the column names
colnames(y)<-c("Activity")
colnames(subject)<-c("Subject")

#use desciptive activity names insted of numbers
y[,1]<-factor(x=y[,1], levels=activity_labels[,1], labels=activity_labels[,2])

#join columns of subject, x and y into the single data set
data<-cbind(subject,y,x)

#find columns which contain mean() or std()
#remark: special characters like '-' or '(' or ')' are converted in
#the headers to the '.'-symbol
neededColumnNumbers<-grep("(\\.mean\\.)|(\\.std\\.)", colnames(data))
#filter only needed columns
data <- data[, c(1,2,neededColumnNumbers)]

tidyDataTable <- data.table(data)
# calculate the mean of all the features for each combibation of activity and subject in the data
tidyDataTable <- tidyDataTable[, lapply(.SD,mean), by=c("Activity","Subject")]

#rename feature columns so that foo-X-std() would become mean(foo-x-std())
newColNames <- sapply(names(tidyDataTable)[-(1:2)], function(name) paste("mean(", name, ")", sep=""))
setnames(tidyDataTable, names(tidyDataTable), c("Activity", "Subject", newColNames))

#write the dataset to the hard drive
write.csv(tidyDataTable, file="tidy.csv")
