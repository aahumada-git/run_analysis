run_analysis
============

Getting and Cleaning Data Project
COOK BOOK

Step 1 - Merges the training and the test sets to create one data set:

	C:\Users\aahumada.SA\MatLab\RStudio\run_analysis\UCI HAR Dataset\test
		subject_test.txt
		X_test.txt
		y_test.txt
	
	C:\Users\aahumada.SA\MatLab\RStudio\run_analysis\UCI HAR Dataset\train
		subject_train.txt
		X_train.txt
		y_train.txt

Step 2 - Extracts only the measurements on the mean and standard deviation for each measurement. 
	*-mean()-*
	*-std()-*
	
	SAMPLE
		features.txt
			1 tBodyAcc-mean()-X
			2 tBodyAcc-mean()-Y
			3 tBodyAcc-mean()-Z
			4 tBodyAcc-std()-X
			5 tBodyAcc-std()-Y
			6 tBodyAcc-std()-Z
			7 tBodyAcc-mad()-X
			8 tBodyAcc-mad()-Y
			9 tBodyAcc-mad()-Z
			       :

Step 4 - Uses descriptive activity names to name the activities in the data set
         Appropriately labels the data set with descriptive activity names. 
		 
	DATA
	- 'train/X_train.txt': Training set.
	- 'test/X_test.txt': Test set.
	
	LABEL ID
	- 'train/y_train.txt': Training labels.
	- 'test/y_test.txt': Test labels.
	
	LABEL CODE
		activity_labels.txt
			1 WALKING
			2 WALKING_UPSTAIRS
			3 WALKING_DOWNSTAIRS
			4 SITTING
			5 STANDING
			6 LAYING

Step 5 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
