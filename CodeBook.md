Code Book

This document describes the code inside `run_analysis.R`.

* Downloading and loading data
* Manipulating data
* Writing final data to CSV

## Downloading and loading data


* This code downloads the UCI HAR zip if it doesn't exist
* It will also prep required folders and extract the UCI data into them
* Reads the activity labels to `activityLabels`
* Reads the column names of data (a.k.a. features) to `features`
* Reads the test `data.frame` to `dtTest`
* Reads the training `data.frame` to `dtTrain`

## Manipulating data

* Merges test data and training data into `dtMerged`
* Strips all non mean/std columns from `dtMerged`
* Merges activity data into `dtMerged` from `dtTestActivity` and `dtTrainActivity`
* Merges subject data into `dtMerged` from `dtTestSubject` and `dtTrainSubject`
* Converts Activity column into a textual description on `dtMerged`
* Summarizes `dtMerged` calculating the average for each column for each activity/subject pair to `tidy`.

Final data frame `tidy` looks like this:

    > head(tidy[, 1:5])
      Activity Subject avg(`tBodyAcc-mean()-X`) avg(`tBodyAcc-mean()-Y`) avg(`tBodyAcc-mean()-Z`)
        1   LAYING       1                0.2215982              -0.04051395               -0.1132036
        2   LAYING       2                0.2813734              -0.01815874               -0.1072456
        3   LAYING       3                0.2755169              -0.01895568               -0.1013005
        4   LAYING       4                0.2635592              -0.01500318               -0.1106882
        5   LAYING       5                0.2783343              -0.01830421               -0.1079376
        6   LAYING       6                0.2486565              -0.01025292               -0.1331196


## Writing final data to CSV

Writes `tidy` data frame to tidy.csv