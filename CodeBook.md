# UCR HAR Analysis Code Book

### Getting And Cleaning Data Assignment

#### Overview

The `run_analysis.R` script uses data from the UCI Human Activity Recognition 
dataset to generate a `tidy.csv` file that consists of 180 rows and 68 columns. 
Each row corresponds to a subject-activity pair. 

#### Columns

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

On the other hand, `fBodyGyroJerkMag` indicates that just 2 columns would exist
in the dataset:

* fBodyBodyGyroJerkMag-mean()
* fBodyBodyGyroJerkMag-std()

#### Merging and Summarizing the Data

The following steps were taken:

1. The datasets in `train/X_train.txt` and `test/X_test.txt` were loaded into
dataframes and then merged into a single dataframe.
2. The dataset in `features.txt` was used to provide column names for the 
merged dataset.
3. Features with names containing `mean()` or `std()` were identified and used
to pare down the dataset.
4. The datasets in `train/y_train.txt` and `test/y_test.txt`, which indicate
which activity each row refers to, were merged into a single dataset before 
being added as a new column on the left of the merged dataset.
5. The datasets in `train/subject_train.txt` and `test/subject_test.txt`, which 
indicate which subject each row refers to, were merged into a single dataset 
before being added as a new column on the left of the merged dataset.
6. At this point the dataset consisted of 10299 rows and 68 columns. For each
subject-activity pair there were numerous measurements, so these were collapsed
into a single row by taking the column means for each such pair. 
7.This collapsed dataset was then given column names from the uncollapsed 
version and ordered first by the subject and then by the activity.
8. Finally the activity IDs were replaced with their corresponding text 
versions obtained from `activity_labels.txt`.