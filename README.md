#Introduction
This repository is for the course project for Coursera Course: [Getting and Cleaning Data](https://class.coursera.org/getdata-015)

##Artifacts
The important artifacts for course project completions are:

- [README.md](./README.md)

- [summarizedTidyDataSet.txt](./TidyData/summarizedTidyDataSet.txt) : tidy data set with the average of each variable for each activity and each subject

- [CodeBook.md](./CodeBook.md) : describes the variables, the data, and any transformations or work that you performed to clean up the data.

- [run_analysis.R](./run_analysis.R) : R script that generates the summarizedTidyDataSet.csv

##Running the script
```
source('./run_analysis.R')
runScript()
```

##What does runScript do?
1. Prepares the R working directory for analysis
2. Downloads the data set
3. Merges the training and the test sets to create one data set.
4. Extracts only the measurements on the mean and standard deviation for each measurement.
5. Uses descriptive activity names to name the activities in the data set
6. Appropriately labels the data set with descriptive variable names. The data set used here is the subjects, activites and the subset extracted as part of step 4.
7. From the data set in step 6, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
8. Saves the labeled dataset from step 6 and the summarized dataset from step 7 to the file system
