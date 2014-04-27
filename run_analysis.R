# Set a buffer size for reading in the data files to prevent memory issues
buffer <- 250

# The data files contain 561 entries, each of which is 16 characters wide
widths <- rep(16, 561)

# Set the file names 
# (this assumes the archive was unzipped in the same directory as this file)
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

# Label the activity column and add it to mergedData
colnames(mergedSubject) <- c("subject")
mergedData <- cbind(mergedSubject, mergedData)

# Save mergedData as a CSV
write.csv(mergedData, file="tidy.csv", row.names=F)