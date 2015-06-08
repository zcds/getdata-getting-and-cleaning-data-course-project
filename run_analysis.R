## This script demonstrates the ability to collect, work with, and clean a data set,
## in this case the "Human Activity Recognition Using Smartphones Data Set" 
## (see http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
## The goal is to prepare tidy data that can be used for later analysis

## It does the following:
## 1. Prepares the R working directory for analysis
## 2. Downloads the data set
## 3. Merges the training and the test sets to create one data set.
## 4. Extracts only the measurements on the mean and standard deviation for each measurement.
## 5. Uses descriptive activity names to name the activities in the data set
## 6. Appropriately labels the data set with descriptive variable names.
## 7. From the data set in step 6, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## 8. Saves the labeled dataset from step 6 and the summarized dataset from step 7 to the file system


## Let's load the R libraries required for our work

library(plyr) ## plyr: Tools for Splitting, Applying and Combining Data
library(reshape2) ## reshape2: Flexibly Reshape Data: A Reboot of the Reshape Package


## Prepares the R working directory for analysis
## Using the current time as part of the name, we create a new data directory
## for each run of this script. This helps us compare the results across
## different runs.
prepareWorkingDirectory <- function(dataDirName) {
  
  ## Since we use the time with second precision, 
  ## normally there will not be any existing directory with this name.
  ## Throw an error with the message to remove the directory in case there is one already.
  if(file.exists(dataDirName)) {
    stop(paste('Directory:', dataDirName, 'already exists. Please delete before running this script again.'))
  }
  
  ## Assured that the directory does not exist, we create it and set it as the working directory
  dir.create(dataDirName);
  setwd(dataDirName)
}


## Download and extracts the data set in the working directory
downloadAndExtractDataSet <- function() {
  download.file(url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', destfile = 'UCI_HAR_Dataset.zip', method = 'curl')
  unzip('UCI_HAR_Dataset.zip')
}

## Merges the training and test datasets and outputs
## a special list that contains the different data frames
mergeData <- function() {
  
  ## Training Set
  subjectTrain <- read.table(file = './UCI HAR Dataset/train/subject_train.txt')
  xTrain <- read.table(file = './UCI HAR Dataset/train/X_train.txt')
  yTrain <- read.table(file = './UCI HAR Dataset/train/y_train.txt')
  
  ## Test set
  subjectTest <- read.table(file = './UCI HAR Dataset/test/subject_test.txt')
  xTest <- read.table(file = './UCI HAR Dataset/test/X_test.txt')
  yTest <- read.table(file = './UCI HAR Dataset/test/y_test.txt')
  
  ## Merge the training and test datasets
  mergedSubjects <- rbind(subjectTrain, subjectTest)
  mergedMeasurements <- rbind(xTrain, xTest)
  mergedActivities <- rbind(yTrain, yTest)
  
  ## Features
  featureLabels <- read.table(file = './UCI HAR Dataset/features.txt') 
  
  ## Activity Labels
  activityLabels <- read.table(file = './UCI HAR Dataset/activity_labels.txt') 
  
  list(
    subjects = mergedSubjects, 
    measurements = mergedMeasurements, 
    activities = mergedActivities,
    featureLabels = featureLabels,
    activityLabels = activityLabels)
}

## Extracts only the features related to mean and Standard Deviation
## using the subset capability in R
subsetMeasurementsOnMeanAndSD = function(measurements, featureLabels) {
  ## Get the indices of the mean and SD columns
  meanAndSDIndices <- grepl("mean\\(\\)|std\\(\\)", featureLabels[,2])
  
  # Get the subset data with only the relevant columns for mean and StdDev
  measurementsSubset <- measurements[, meanAndSDIndices]
  colnames(measurementsSubset) <- featureLabels[meanAndSDIndices, 2]
  
  measurementsSubset
}


## Returns the activities data frame with the descriptive activity labels
applyDescriptiveActivityNames <- function(activities, activityLabels) {
  activities[,1] <- activityLabels[activities[,1], 2]
  names(activities) <- 'activity'
  
  activities
}

## Creates the tidy data set by merging the subject, activities and measurements (the subset one)
prepareTidyDataSet <- function(subjects, activities, meanAndSDMeasurements) {
  tidyData <- cbind(subjects, activities, meanAndSDMeasurements)
  colnames(tidyData) <- factor(c('subject', 'activity', as.character(colnames(meanAndSDMeasurements))))
  
  tidyData
}

## Create the summarized tidy set that provides the 
## average of each variable for each activity and each subject.
createSummarizedTidyDataSet <- function(tidyData) {
  # Use the Subject and Activity columns to melt the data for subsequent processing
  meltedTidyData <- melt(data = tidyData, id = c('subject', 'activity'))
  
  # Calculate the mean for each feature per subject per activity.
  summarizedTidyData <- dcast(meltedTidyData, subject + activity ~ variable, mean)
  
  summarizedTidyData
}

## Writes the two tidy data sets to files
writeDataSetsToFile <- function(labeledDataSet, summarizedTidyDataSet) {
  dir.create('./TidyData');
  write.csv(labeledDataSet, file= './TidyData/labeledDataSet.csv', row.names = FALSE)
  write.csv(summarizedTidyDataSet, file= './TidyData/summarizedTidyDataSet.csv', row.names = FALSE)
}




## Now for the steps that automate the task
runScript <- function() {
  ## Store the initial values so that we can return to the original state we found the system in
  origWorkingDir <- getwd()
  scriptStartTime <- Sys.time()
  dataDirName <- paste('./data_', format(scriptStartTime, '%Y%m%d_%H%M%S'), sep = '')
  
  
  ## 1. Prepares the R working directory for analysis
  prepareWorkingDirectory(dataDirName)
  print('Working directory ready!')
  
  ## 2. Downloads the data set
  downloadAndExtractDataSet()
  print('Dataset downloaded and extracted!')
  
  ## 3. Merges the training and the test sets to create one data set.
  data <- mergeData()
  print('Merged data ready!')
  
  ## 4. Extracts only the measurements on the mean and standard deviation for each measurement.
  meanAndSDSubset <- subsetMeasurementsOnMeanAndSD(data$measurements, data$featureLabels)
  print('Subset dataset with just the measurements on Mean and Standard Deviations ready!')
  
  ## 5. Uses descriptive activity names to name the activities in the data set
  activitiesWithDescriptiveLables <- applyDescriptiveActivityNames(data$activities, data$activityLabels)
  print('Acitivites now have descriptive labels')
  
  ## 6. Appropriately labels the data set with descriptive variable names.
  labeledDataSet <- prepareTidyDataSet(data$subjects, activitiesWithDescriptiveLables, meanAndSDSubset)
  print('Labeled data set for the subset ready!')
  
  ## 7. From the data set in step 6, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  summarizedTidyDataSet <- createSummarizedTidyDataSet(labeledDataSet)
  print('Independent tidy data set with the average of each variable for each activity and each subject ready!')
  
  ## 8. Saves the labeled dataset from step 6 and the summarized dataset from step 7 to the file sytem
  writeDataSetsToFile(labeledDataSet, summarizedTidyDataSet)
  print(paste("Tidy data sets successfully generated in:", dataDirName, '/TidyData'))
  
  ## Eventually set the home directory as the working directory
  setwd(origWorkingDir)
  
}