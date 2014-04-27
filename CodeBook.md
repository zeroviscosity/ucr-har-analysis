# UCR HAR Analysis Code Book

### Getting And Cleaning Data Assignment

The `run_analysis.R` script generates a `tidy.csv` file from the UCI Human
Activity Recognition dataset. The dataset in `tidy.csv` consists of 180 rows
and 68 columns. Each row corresponds to a subject-activity pair. 

The first column, `subject` corresponds to an integer ID in the range from 
1 to 30 (inclusive) that identifies the human subject in the original 
experiment.

The second column, `activity`, contains one of the following labels that 
describes the activity being performed:
- WALKING
- WALKING_UPSTAIRS 
- WALKING_DOWNSTAIRS
- SITTING
- STANDING
- LAYING

The next 66 columns contain average mean and average standard deviation values
for the various measurements made for the subject-activity pair in question. 
For each of the following there is one `mean()` and one `std()` column:
* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag
Labels prefixed with `t` are time-based and measured in seconds while those
prefixed with `f` are frequency-based and measured in Hertz. Labels ending 
in -XYZ are split into -X, -Y and -Z values. In other words, `tBodyAcc-XYZ` 
indicates that the following 6 columns would exist in the dataset:
* tBodyAcc-mean()-X
* tBodyAcc-mean()-Y
* tBodyAcc-mean()-Z
* tBodyAcc-std()-X
* tBodyAcc-std()-Y
* tBodyAcc-std()-Z
