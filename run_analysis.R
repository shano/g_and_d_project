library(data.table)
library(tractor.base)
library(sqldf)

### DOWNLOAD DATA ###
if(!file.exists('./dataset')) { 
        dir.create('./dataset') 
        download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', 'dataset.zip', method="curl")
        unz('dataset.zip', 'dataset')
}


### READ IN DATA ###
features <- read.table('./dataset/features.txt', sep="")
activityLabels <- read.table('./dataset/activity_labels.txt', sep="")

# Test dataset
dtTest <- read.table('./dataset/test/X_test.txt', sep="")

# Adding in the activity types
dtTestActivity <- read.table('./dataset/test/y_test.txt')

dtTestSubject <- read.table('./dataset/test/subject_test.txt', sep="")

# Train dataset
dtTrain <- read.table('./dataset/train/X_train.txt', sep="")
# Adding in the activity types
dtTrainActivity <- read.table('./dataset/train/y_train.txt', sep="")
dtTrainSubject <- read.table('./dataset/train/subject_train.txt', sep="")

# 1. Merges the training and the test sets to create one data set.
dtMerged = rbind(dtTest, dtTrain)

# 4. Appropriately labels the data set with descriptive variable names.
colnames(dtMerged) <- features$V2

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
dtMerged <- dtMerged[ , grepl( "mean\\(\\)|std\\(\\)" , names( dtMerged ) ) ]

# 3. Uses descriptive activity names to name the activities in the data set
dtMerged$Activity <- unlist(rbind(dtTestActivity, dtTrainActivity))
dtMerged$Subject <- unlist(rbind(dtTestSubject, dtTrainSubject))

activityVec <- as.list(activityLabels[['V2']])
names(activityVec) <- as.character(activityLabels[['V1']])

for (i in 1:nrow(activityLabels)) {
        row = activityLabels[i,]
        id = as.character(row$V1)
        label = as.character(row$V2)
        dtMerged$Activity[dtMerged$Activity == id] <- label
}

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# Using sqldf as faster than data.tables
selector <- gsub("\\s", "",paste("avg(`", implode(grep("mean\\(\\)|std\\(\\)", names(dtMerged), value = TRUE), "`), avg(`"), "`)"))
tidy <- sqldf(sprintf("select Activity, Subject, %s from dtMerged group by Activity, Subject", selector ))
write.table(tidy, 'dataset/tidy.csv', row.names=FALSE)
