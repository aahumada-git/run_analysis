run_analysis
============

### Getting and Cleaning Data Project 
## COOK BOOK

* Step 1 - Merges the training and the test sets to create one data set:

	Copy files from "UCI HAR Dataset\test" directory to "UCI HAR Dataset\merge" directory:
		subject_test.txt  => subject_merge.txt
		X_test.txt        => X_merge.txt
		y_test.txt        => y_merge.txt
	
	Append Files from "UCI HAR Dataset\train" directory to ""UCI HAR Dataset\merge" directory:
		subject_merge.txt + subject_train.txt
		X_merge.txt       + X_train.txt
		y_merge.txt       + y_train.txt
		
* Step 2 - Extracts only the measurements on the mean and standard deviation for each measurement:

	Load features.txt file into a table and using logical grep filter features that contain worrd "mean" and "std" geting colums index.
	
		Header <- Feature[ grepl("mean|std",Feature$V2), "V1"]
	
	With Header index create requestes sub set:
	
		data   <- data.table( cbind( Subject, y, X[,Header] ) )
		
* Step 4 - Uses descriptive activity names to name the activities in the data set. Appropriately labels the data set with descriptive activity names:

	Load activity_labels.txt into Activity table and replace activity id for its label:
	
		data$Activity <- Activity$V2[ data$Activity ]

* Step 5 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

	Grouping according request:
	
		TIDY <- data[, lapply(.SD,mean),by=list(Activity,Subject), .SDcols=3:dim(data)[2]]
	
