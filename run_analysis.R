
library(data.table)

#Download the data and unzip the data

if(!file.exists("downloads-zip")) {
    dir.create("downloads-zip")
}
if(!file.exists("downloads-uzip")) {
    dir.create("downloads-uzip")
}

Url1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFl <- file.path("downloads-zip","fls.zip")
outDir <- file.path("downloads-unzip")
download.file(Url1,zipFl)
unzip(zipFl,exdir=outDir)

wkDir <-file.path(outDir,"UCI HAR Dataset")
activityDf <- read.table(file.path(wkDir,"activity_labels.txt"),as.is=TRUE)[,2]
featuresDf <- read.table(file.path(wkDir,"features.txt"),as.is=TRUE)[,2]

#Read the test datasets
subjTestDf <- read.table(file.path(wkDir,"test","subject_test.txt"),as.is=TRUE)
xTestDf <- read.table(file.path(wkDir,"test","X_test.txt"),as.is=TRUE)
yTestDf <- read.table(file.path(wkDir,"test","y_test.txt"),as.is=TRUE)

#Read the training dataset
subjTrainDf <- read.table(file.path(wkDir,"train","subject_train.txt"),as.is=TRUE)
xTrainDf <- read.table(file.path(wkDir,"train","X_train.txt"),as.is=TRUE)
yTrainDf <- read.table(file.path(wkDir,"train","y_train.txt"),as.is=TRUE)

#merge the the training and the test sets to create one data set.
dfx <- rbind(xTrainDf,xTestDf)
dfy <- rbind(yTrainDf,yTestDf)
dfsubj <- rbind(subjTrainDf,subjTestDf)

#Extract only the measurements on the mean and standard deviation for each measurement.
ixMeanStd <- grep("mean\\(|std\\(",featuresDf)
dfx <- dfx[,ixMeanStd]

#Use descriptive activity names to name the activities in the data set
dfy <- as.data.frame(activityDf[dfy[,1]])

#Appropriately label the data set with descriptive variable names.
names(dfx)<-featuresDf[ixMeanStd]
names(dfy) <- "Activity"
names(dfsubj) <- "Subject"
dfall <- cbind(dfsubj,dfy,dfx)
setDT(dfall)

#creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyDT <- dfall[,lapply(.SD, mean), by =.(Subject,Activity)]
write.table(tidyDT, file = "Clean.txt",row.names = FALSE)

