#
# Getting and Cleaning Data Project
#

# DATA SET:
#     http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#
# DATA SAMPLE:
#     https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


###
#
#  Global Variable
#
###
BASE_DIR <- "C:\\Users\\aahumada.SA\\MatLab\\RStudio\\run_analysis\\UCI HAR Dataset"

FEATURE   <- paste(BASE_DIR, "features.txt", sep = "\\")
ACTIVITY  <- paste(BASE_DIR, "activity_labels.txt", sep = "\\")
MERGE_DIR <- paste(BASE_DIR, "merge", sep = "\\")
TEST_DIR  <- paste(BASE_DIR, "test" , sep = "\\")
TRAIN_DIR <- paste(BASE_DIR, "train", sep = "\\")

OUTPUT    <- paste(BASE_DIR, "tydy.txt", sep = "\\")

SUBJECT_MERGE <- paste( MERGE_DIR, "subject_merge.txt", sep = "\\")
      X_MERGE <- paste( MERGE_DIR,       "X_merge.txt", sep = "\\")
      y_MERGE <- paste( MERGE_DIR,       "y_merge.txt", sep = "\\")


SUBJECT_TEST <- paste( TEST_DIR, "subject_test.txt", sep = "\\")
      X_TEST <- paste( TEST_DIR,       "X_test.txt", sep = "\\")
      y_TEST <- paste( TEST_DIR,       "y_test.txt", sep = "\\")

SUBJECT_TRAIN <- paste( TRAIN_DIR, "subject_train.txt", sep = "\\")
      X_TRAIN <- paste( TRAIN_DIR,       "X_train.txt", sep = "\\")
      y_TRAIN <- paste( TRAIN_DIR,       "y_train.txt", sep = "\\")

###
#
#  MERGE FILES
#
###
library(data.table)
library(stringr)

if (!file.exists(MERGE_DIR)) {
  dir.create(MERGE_DIR)
}

if (file.exists(SUBJECT_MERGE)) {file.remove(SUBJECT_MERGE)}
if (file.exists(      X_MERGE)) {file.remove(      X_MERGE)}
if (file.exists(      y_MERGE)) {file.remove(      y_MERGE)}

file.copy(SUBJECT_TRAIN, SUBJECT_MERGE); file.append(SUBJECT_MERGE, SUBJECT_TEST)
file.copy(      X_TRAIN,       X_MERGE); file.append(      X_MERGE,       X_TEST)
file.copy(      y_TRAIN,       y_MERGE); file.append(      y_MERGE,       y_TEST)

Feature  <- read.table(FEATURE , header=FALSE)
Activity <- read.table(ACTIVITY, header=FALSE)

Subject  <- read.table(SUBJECT_MERGE, header=FALSE)
X        <- read.table(      X_MERGE, header=FALSE)
y        <- read.table(      y_MERGE, header=FALSE)


# Get Header Index
Header <- Feature[ grepl("mean|std",Feature$V2), "V1"]

# Bind Data Columns
data        <- data.table( cbind( Subject, y, X[,Header] ) )

# Set Headers Names
nam         <- Feature$V2[Header]
nam         <- str_replace_all(nam, "([-])" , "_" )
nam         <- str_replace_all(nam, "([()])", "" )
setnames(data, c( "Subject", "Activity", as.character(nam)))

# Trasform Activity code to Activity Name
data$Activity <- Activity$V2[ data$Activity ]

# Create grouping table
TIDY <- data[, lapply(.SD,mean),by=list(Activity,Subject), .SDcols=3:dim(data)[2]]

write.table(TIDY, file=OUTPUT, row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE)

