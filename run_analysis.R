# Set a buffer size for reading in the data files to prevent memory issues
buffer <- 250

# The data files contain 561 entries, each of which is 16 characters wide
widths <- rep(16, 561)

# Set the file names 
# (this assumes the archive was unzipped in the same directory as this file)
activityLabelsFile <- "./UCI HAR Dataset/activity_labels.txt"
featuresFile <- "./UCI HAR Dataset/features.txt"
trainDataFile <- "./UCI HAR Dataset/train/X_train.txt"
trainSubjectFile <- "./UCI HAR Dataset/train/subject_train.txt"
trainActivityFile <- "./UCI HAR Dataset/train/y_train.txt"
testDataFile <- "./UCI HAR Dataset/test/X_test.txt"
testSubjectFile <- "./UCI HAR Dataset/test/subject_test.txt"
testActivityFile <- "./UCI HAR Dataset/test/y_test.txt"

# Load the training and test data and merge them into one data frame
trainData <- read.fwf(trainDataFile, widths=widths, header=F, buffersize=buffer)
testData <- read.fwf(testDataFile, widths=widths, header=F, buffersize=buffer)
mergedData <- rbind(trainData, testData)

# Load the features and use them for column names
features <- read.delim(featuresFile, header=F, sep=" ")
featureNames <- features[,2]
colnames(mergedData) <- featureNames

# Extract the columns that contain "mean()" or "std()"
colIdx <- grep("(mean|std)\\(\\)", featureNames)
mergedData <- mergedData[,colIdx]

# Load the activity files and merge them together
trainActivity <- read.delim(trainActivityFile, header=F)
testActivity <- read.delim(testActivityFile, header=F)
mergedActivity <- rbind(trainActivity, testActivity)

# Label the activity column and add it to mergedData
colnames(mergedActivity) <- c("activity")
mergedData <- cbind(mergedActivity, mergedData)

# Load the subject files and merge them together
trainSubject <- read.delim(trainSubjectFile, header=F)
testSubject <- read.delim(testSubjectFile, header=F)
mergedSubject <- rbind(trainSubject, testSubject)

# Label the subject column and add it to mergedData
colnames(mergedSubject) <- c("subject")
mergedData <- cbind(mergedSubject, mergedData)

# Prepare the tidy dataset
# For each subject-activity pair, find the mean of each of the data columns
tidyData <- data.frame()
for (subject in 1:30) {
    for (activity in 1:6) {
        dataRows <- mergedData[(mergedData$subject == subject & 
                               mergedData$activity == activity), c(-1,-2)]
        tidyData <- rbind(tidyData, c(subject, activity, colMeans(dataRows)))
    }
}

# Add the column names 
colnames(tidyData) <- colnames(mergedData)

# Order the data by subject and by activity
tidyData <- tidyData[order(tidyData$subject, tidyData$activity),]

# Load the acitivity labels and use them to relabel the activity column
activityLabelsData <- read.delim(activityLabelsFile, header=F, sep=" ")
activityLabels <- as.vector(activityLabelsData[, 2])
tidyData$activity <- sapply(tidyData$activity, function(idx) activityLabels[idx])

# Save tidyData as a CSV
write.csv(tidyData, file="tidy.csv", row.names=F)
