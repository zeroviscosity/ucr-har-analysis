# UCR HAR Analysis Code Book

### Getting And Cleaning Data Assignment

The `run_analysis.R` script generates a `tidy.csv` file from the UCI Human
Activity Recognition dataset. The dataset in `tidy.csv` consists of 180 rows
and 68 columns. Each row corresponds to a subject-activity pair. The columns
are:

* Subject - an integer ID in the range from 1 to 30 (inclusive) that identifies
the human subject in the original experiment
* Activity - one of the following labels that describes the activity being performed:
	** WALKING
	** WALKING_UPSTAIRS 
	** WALKING_DOWNSTAIRS
	** SITTING
	** STANDING
	** LAYING
* ...