## Original Data (Human Activity Recognition Using Smartphones Data Set)

- [Source](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 
- [Full description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Data Transformation Steps
1. Prepares the R working directory for analysis
  1. In order to retain previous datasets, the script uses the current time to create separate directories for each run.
  2. Set the working directory to this newly created directory.
2. Downloads the data set
  1. The downloaded dataset is in ZIP format. The scrip unzips the downloaded file in the working directory.
3. Merges the training and the test sets to create one data set.
  1. As part of task 1 for the course project, the training and test data sets are merged using rbind.
  2. The entire data set is made available as a special list type convenience object. 
4. Extracts only the measurements on the mean and standard deviation for each measurement.
  1. As part of task 2 for the course project, using the feature labels which contains `mean()` or `std()`, a subset `data.frame` is created from the measurements.
5. Uses descriptive activity names to name the activities in the data set
  1. As part of task 3 for the course project, using the activity labels, a new activities `data.frame` is createdd that uses the descriptive activity labels instead of the numeric values.
6. Appropriately labels the data set with descriptive variable names. The data set used here is the subjects, activites and the subset extracted as part of step 4.
  1. As part of task 4 for the course project, the subjects `data.frame`, activities `data.frame` (from step 5) and the subset measurements `data.frame` from step 4, are merged and labeled to improve readability.
7. From the data set in step 6, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  1. As part of task 5 for the course project, a new data set is created with the average of each variable for each activity and each subject.
8. Saves the labeled dataset from step 6 and the summarized dataset from step 7 to the file system
  1. Eventually, the two tidy data sets are saved to the file system under the `./TidyData` directory.

## Output Data Files
1. [labeledDataSet.csv](./TidyData/labeledDataSet.csv)
This file holds the tidy data for only the measurements on the mean and standard deviation for each measurement along with the subject and descriptive activity label. This is the output from step 6 above

1. [summarizedTidyDataSet.csv](./TidyData/summarizedTidyDataSet.csv)
This file holds the tidy data for the average of variables related to Mean and Standard Deviation for each activity and each subject.

## Data Columns
Thes are basically the 66 columns for the features related to Mean and Standard Deviation from the original measurements. The first two are added for the Subject and Activity respectively.

1. subject
1. activity
1. tBodyAcc-mean()-X
1. tBodyAcc-mean()-Y
1. tBodyAcc-mean()-Z
1. tBodyAcc-std()-X
1. tBodyAcc-std()-Y
1. tBodyAcc-std()-Z
1. tGravityAcc-mean()-X
1. tGravityAcc-mean()-Y
1. tGravityAcc-mean()-Z
1. tGravityAcc-std()-X
1. tGravityAcc-std()-Y
1. tGravityAcc-std()-Z
1. tBodyAccJerk-mean()-X
1. tBodyAccJerk-mean()-Y
1. tBodyAccJerk-mean()-Z
1. tBodyAccJerk-std()-X
1. tBodyAccJerk-std()-Y
1. tBodyAccJerk-std()-Z
1. tBodyGyro-mean()-X
1. tBodyGyro-mean()-Y
1. tBodyGyro-mean()-Z
1. tBodyGyro-std()-X
1. tBodyGyro-std()-Y
1. tBodyGyro-std()-Z
1. tBodyGyroJerk-mean()-X
1. tBodyGyroJerk-mean()-Y
1. tBodyGyroJerk-mean()-Z
1. tBodyGyroJerk-std()-X
1. tBodyGyroJerk-std()-Y
1. tBodyGyroJerk-std()-Z
1. tBodyAccMag-mean()
1. tBodyAccMag-std()
1. tGravityAccMag-mean()
1. tGravityAccMag-std()
1. tBodyAccJerkMag-mean()
1. tBodyAccJerkMag-std()
1. tBodyGyroMag-mean()
1. tBodyGyroMag-std()
1. tBodyGyroJerkMag-mean()
1. tBodyGyroJerkMag-std()
1. fBodyAcc-mean()-X
1. fBodyAcc-mean()-Y
1. fBodyAcc-mean()-Z
1. fBodyAcc-std()-X
1. fBodyAcc-std()-Y
1. fBodyAcc-std()-Z
1. fBodyAccJerk-mean()-X
1. fBodyAccJerk-mean()-Y
1. fBodyAccJerk-mean()-Z
1. fBodyAccJerk-std()-X
1. fBodyAccJerk-std()-Y
1. fBodyAccJerk-std()-Z
1. fBodyGyro-mean()-X
1. fBodyGyro-mean()-Y
1. fBodyGyro-mean()-Z
1. fBodyGyro-std()-X
1. fBodyGyro-std()-Y
1. fBodyGyro-std()-Z
1. fBodyAccMag-mean()
1. fBodyAccMag-std()
1. fBodyBodyAccJerkMag-mean()
1. fBodyBodyAccJerkMag-std()
1. fBodyBodyGyroMag-mean()
1. fBodyBodyGyroMag-std()
1. fBodyBodyGyroJerkMag-mean()
1. fBodyBodyGyroJerkMag-std()
