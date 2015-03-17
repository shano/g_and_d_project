library('data.table')

### READ IN DATA ###
features <- read.table('./dataset/features.txt', sep="")
activityLabels <- read.table('./dataset/activity_labels.txt', sep="")

# Test dataset
dtTest <- read.table('./dataset/test/X_test.txt', sep="")

# Adding in the activity types
dtTestActivity <- read.table('./dataset/test/y_test.txt')

# Train dataset
dtTrain <- read.table('./dataset/train/X_train.txt', sep="")
# Adding in the activity types
dtTrainActivity <- read.table('./dataset/train/y_train.txt', sep="")

# 1. Merges the training and the test sets to create one data set.
dtMerged = rbind(dtTest, dtTrain)

# 4. Appropriately labels the data set with descriptive variable names.
colnames(dtMerged) <- features$V2

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
dtMerged = dtMerged[ , grepl( "mean\\(\\)|std\\(\\)" , names( dtMerged ) ) ]

# 3. Uses descriptive activity names to name the activities in the data set
dtMerged$Activity = unlist(rbind(dtTestActivity, dtTrainActivity))
#dtMerged = merge(dtMerged, activityLabels, by.x='Activity', by.y='')

print(head(dtMerged))
print(dtMerged$Activity)