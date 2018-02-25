#Getting and Cleaning Data Course Project
##Purpose
The purpose of this project is to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. Please find the following items

-a tidy data set  
-a link to a Github repository with your script for performing the analysis  
-a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 

 
###Source for this analysis:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


##Process
The dataset is downloaded into the downloads-zip directory. It is then unzipped into the downloads-unzip directory. 

The unzipped file consists of a directory UCI HAR Dataset and 2 subdirectories called test and train.  

The data from the train and test data sets are loaded into data frames and then merged together into 1 data frame. 

A dataset is created by extracting the mean and standard deviation for each measurement, together with the associated activity and subject id. Labels are given to these measures and the subject id, Descriptive activity names replace the activity id. 

A second, independent tidy dataset is then created with the average of each variable for each activity and each subject. This data set is called "Clean.txt".
  
