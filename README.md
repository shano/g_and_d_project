Getting and Cleaning Project
====================================================================

Goals of the project
-------------------------------------------

- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names. 
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


Tasks
---------------------------------------------
- Merge the training X_test and X_train together
- Remove everything but std and mean data
- Merge with the Y_test and Y_train and then use the activity_labels to apply descriptive labels
- Create the new data set